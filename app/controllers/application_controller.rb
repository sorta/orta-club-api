class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_json_error :not_found, { details: e }
  end

  def render_json_error(status, extra = {})
    response_status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

    error = {
      title: I18n.t("error_messages.#{status}.title"),
      status: response_status,
      code: I18n.t("error_messages.#{status}.code")
    }.merge(extra)

    render json: { errors: [error] }, status: response_status
  end
end
