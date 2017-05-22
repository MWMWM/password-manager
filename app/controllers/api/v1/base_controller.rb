class Api::V1::BaseController < ApplicationController
  respond_to :json

  before_action :authenticate_account

  def current_account
    @current_account ||= Account.find_by(username: request.headers['Username']).
                         try(:authenticate, request.headers['Password'])
  end

  def authenticate_account
    return if current_account
    render json: { errors: 'Not authenticated' }, status: :unauthorized
  end
end
