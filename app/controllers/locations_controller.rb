class LocationsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_location, only: [:show, :update, :destroy]

  # GET /locations
  def index
    @locations = Location.all

    render json: LocationSerializer.new(@locations).serializable_hash
  end

  # GET /locations/1
  def show
    render json: LocationSerializer.new(@location).serializable_hash
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if @location.save
      render json: LocationSerializer.new(@location).serializable_hash, status: :created, location: @location
    else
      render_json_error :unprocessable_entity, { details: @location.errors }
    end
  end

  # PATCH/PUT /locations/1
  def update
    if @location.update(location_params)
      render json: LocationSerializer.new(@location).serializable_hash, status: :created, location: @location
    else
      render_json_error :unprocessable_entity, { details: @location.errors }
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.from_jsonapi.require(:location).permit(:name)
    end
end
