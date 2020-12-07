class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
  rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing
  rescue_from VenmoApiError,                       with: :render_api_error

  private

  def render_not_found(exception)
    logger.info { exception }
    render json: { error: I18n.t('api.v1.errors.not_found') }, status: :not_found
  end

  def render_record_invalid(exception)
    logger.info { exception }
    render json: { errors: exception.record.errors.as_json }, status: :bad_request
  end

  def render_parameter_missing(exception)
    logger.info { exception }
    render json: { error: I18n.t('api.errors.missing_param') }, status: :unprocessable_entity
  end

  def render_api_error(exception)
    logger.info { exception }
    render json: { errors: exception.message }, status: :bad_request
  end
end
