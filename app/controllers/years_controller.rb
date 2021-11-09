class YearsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_year, only: [:show, :update, :destroy]

  # GET /years
  def index
    @years = Year.includes(donnings: [:gay_apparel, :location, :member]).all

    options = {}
    options[:include] = [:donnings, :'donnings.location.name', :'donnings.gay_apparel.name', :'donnings.member.name_first']
    # options[:fields] = {
    #   donnings: {
    #     gay_apparel: [:name],
    #     location: [:name],
    #     member: [:name_first, :name_last]
    #   }
    # }

    render json: YearSerializer.new(@years, options).serializable_hash
  end

  # GET /years/1
  def show
    render json: YearSerializer.new(@year).serializable_hash
  end

  # POST /years
  def create
    @year = Year.new(year_params)

    if @year.save
      render json: YearSerializer.new(@year).serializable_hash, status: :created, location: @year
    else
      render_json_error :unprocessable_entity, { details: @year.errors }
    end
  end

  # PATCH/PUT /years/1
  def update
    if @year.update(year_params)
      render json: YearSerializer.new(@year).serializable_hash, status: :created, location: @year
    else
      render_json_error :unprocessable_entity, { details: @year.errors }
    end
  end

  # DELETE /years/1
  def destroy
    @year.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_year
      @year = Year.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def year_params
      params.from_jsonapi.require(:year).permit(:num)
    end
end
