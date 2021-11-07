class DonningsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_donning, only: [:show, :update, :destroy]

  # GET /donnings
  def index
    @donnings = Donning.all

    render json: DonningSerializer.new(@donnings).serializable_hash
  end

  # GET /donnings/1
  def show
    render json: DonningSerializer.new(@donning).serializable_hash
  end

  # POST /donnings
  def create
    @donning = Donning.new(donning_params)

    if @donning.save
      render json: DonningSerializer.new(@donning).serializable_hash, status: :created, location: @donning
    else
      render_json_error :unprocessable_entity, { details: @donning.errors }
    end
  end

  # PATCH/PUT /donnings/1
  def update
    if @donning.update(donning_params)
      render json: DonningSerializer.new(@donning).serializable_hash, status: :created, location: @donning
    else
      render_json_error :unprocessable_entity, { details: @donning.errors }
    end
  end

  # DELETE /donnings/1
  def destroy
    @donning.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donning
      @donning = Donning.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def donning_params
      params.from_jsonapi.require(:donning).permit(:gay_apparel_id, :member_id, :year_id)
    end
end
