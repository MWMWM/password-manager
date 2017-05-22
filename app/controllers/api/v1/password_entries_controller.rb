class Api::V1::PasswordEntriesController < Api::V1::BaseController
  def show
    entry = current_account.password_entries.find(params[:id])
    entry.master_password = request.headers['Password']
    respond_with entry
  end
end
