# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected

  def current_user
    @token&.user
  end

  def authenticate
    @token = authentication_token
    render_unauthorized unless @token
  end

  def account
    current_user.account
  end

  def plans
    account.plans
  end

  private

  def authentication_token
    authenticate_with_http_token do |token, _options|
      AuthenticationToken.find_by(token: token)
    end
  end

  def render_unauthorized
    headers['WWW-authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: :unauthorized
  end
end
