class Api::V1::PasswordEntriesController < Api::V1::BaseController
  before_action :find_password_entry, except: [:create]

  def show
    @entry.master_password = Account::HARDCODED_PASSWORD
    respond_with @entry
  end

  def create
    @entry = current_account.password_entries.create(entry_params)
    respond_with :api, :v1, @entry
  end

  def update
    @entry.update(entry_params)
    respond_with @entry
  end

  def destroy
    respond_with @entry.destroy
  end

  private

  def find_password_entry
    @entry = current_account.password_entries.find(params[:id])
  end

  def entry_params
    p = params.require(:password_entry).permit(:site_name, :site_url,
                                               :username, :raw_password)
    p.merge(master_password: Account::HARDCODED_PASSWORD)
  end
end
