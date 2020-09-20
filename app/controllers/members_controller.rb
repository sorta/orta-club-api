class MembersController < ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]

  # GET /members
  def index
    @members = Member.all

    render json: MemberSerializer.new(@members).serializable_hash
  end

  # GET /members/1
  def show
    render json: MemberSerializer.new(@member).serializable_hash
  end

  # POST /members
  def create
    @member = Member.new(create_params)
    p ['MEM', @member]

    if @member.save
      render json: MemberSerializer.new(@member).serializable_hash, status: :created, location: @member
    else
      render_json_error :unprocessable_entity, { details: @member.errors }
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(update_params)
      render json: MemberSerializer.new(@member).serializable_hash
    else
      render_json_error :unprocessable_entity, { details: @member.errors }
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def create_params
      p ['PARA', params]
      params.require(:member).permit(:name_first, 
        :name_middle, 
        :name_last, 
        :birthdate, 
        :is_approved, 
        :slug
      )
    end

    def update_params
      params.require(:attributes).permit(
        :name_first, 
        :name_middle, 
        :name_last, 
        :birthdate, 
        :is_approved
      )
    end
end
