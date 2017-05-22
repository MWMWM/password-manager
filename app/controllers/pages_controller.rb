class PagesController < ApplicationController
  def index
    @password_entries = current_account.password_entries
  end
end
