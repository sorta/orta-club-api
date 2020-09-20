class UsersController < ApplicationController
  before_action :authenticate_request!, except: [:create, :login]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(create_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(update_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # POST /users/login
  def login
    user = User.find_by(email: login_params[:email].to_s.downcase)

    if user&.authenticate(login_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { data: { auth_token: auth_token } }, status: :ok
    else
      render_json_error :unauthorized, { details: 'Invalid username/password' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
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
          :password,
          :password_confirmation,
          :member_id
        )
    end

    def login_params
      params.require(:xardion)
    end
end
