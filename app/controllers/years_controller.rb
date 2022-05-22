class YearsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_year, only: [:show, :update, :destroy]

  # GET /years
  def index
    inclusions = year_include_params[:include].to_h
    @years = Year.includes(inclusions).all

    options = {}
    options[:include] = inclusions.map do |key, valueArray|
      valueArray.map do |value|
        "#{key}.#{value}"
      end
    end.flatten

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

    def year_include_params
      # params.permit(include: [
      #   donnings: [
      #     location: [:name],
      #     gay_apparel: [:name],
      #     member: [:name_first]
      #   ]
      # ])
      params.permit(include: [donnings: []])
    end
end
