require 'application_responder'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  http_basic_authenticate_with name: Account::HARDCODED_USERNAME,
                               password: Account::HARDCODED_PASSWORD

  def current_account
    @current_account ||= Account.find_by(username: Account::HARDCODED_USERNAME).
                         try(:authenticate, Account::HARDCODED_PASSWORD)
  end
end
