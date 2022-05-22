class GayApparelsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_gay_apparel, only: [:show, :update, :destroy]

  # GET /gay_apparels
  def index
    @gay_apparels = GayApparel.all

    render json: GayApparelSerializer.new(@gay_apparels).serializable_hash
  end

  # GET /gay_apparels/1
  def show
    render json: GayApparelSerializer.new(@gay_apparel).serializable_hash
  end

  # POST /gay_apparels
  def create
    @gay_apparel = GayApparel.new(gay_apparel_params)

    if @gay_apparel.save
      render json: GayApparelSerializer.new(@gay_apparel).serializable_hash, status: :created, gay_apparel: @gay_apparel
    else
      render_json_error :unprocessable_entity, { details: @gay_apparel.errors }
    end
  end

  # PATCH/PUT /gay_apparels/1
  def update
    if @gay_apparel.update(gay_apparel_params)
      render json: GayApparelSerializer.new(@gay_apparel).serializable_hash, status: :created, gay_apparel: @gay_apparel
    else
      render_json_error :unprocessable_entity, { details: @gay_apparel.errors }
    end
  end

  # DELETE /gay_apparels/1
  def destroy
    @gay_apparel.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gay_apparel
      @gay_apparel = GayApparel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gay_apparel_params
      params.from_jsonapi.require(:gay_apparel).permit(:name)
    end
end
