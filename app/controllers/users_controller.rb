class UsersController < ApplicationController
  before_action :authenticate_request!, except: [:create, :login]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    authorize User
    @users = User.all

    render json: UserSerializer.new(@users).serializable_hash
  end

  # GET /users/1
  def show
    options = {}
    options[:include] = [:member]
    render json: UserSerializer.new(@user, options).serializable_hash
  end

  # POST /users
  def create
    authorize User
    @user = User.new(create_params)

    if @user.save
      render json: UserSerializer.new(@user).serializable_hash, status: :created, location: @user
    else
      render_json_error :unprocessable_entity, { details: @user.errors }
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(update_params)
      render json: UserSerializer.new(@user).serializable_hash
    else
      render_json_error :unprocessable_entity, { details: @user.errors }
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # POST /users/login
  def login
    login_details = login_params
    user = User.find_by(email: login_details[:email].to_s.downcase)

    if user&.authenticate(login_details[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { token: auth_token, id: user.id }, status: :ok
    else
      render_json_error :unauthorized, { details: 'Invalid username/password' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      authorize @user
    end

    # Only allow a trusted parameter "white list" through.
    def create_params
      params.from_jsonapi
        .require(:user)
        .permit(
          :email,
          :password,
          :password_confirmation,
          :member_id
        )
    end

    def update_params
      params.from_jsonapi
        .require(:user)
        .permit(
          :email,
          :member_id
        )
    end

    def login_params
      params
        .require(:user)
        .permit(
          :email,
          :password
        )
    end
end
