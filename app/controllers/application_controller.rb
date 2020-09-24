class ApplicationController < ActionController::API
  require 'json_web_token'
  include Pundit
  # after_action :verify_authorized

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

  protected

  # Validates the token and user and sets the @current_user scope
  def authenticate_request!
    if !payload || !JsonWebToken.valid_payload(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render_json_error :unauthorized
  end

  private

  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

  # Sets the @current_user with the user_id from payload
  def load_current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end

  def current_user
    @current_user
  end
end
