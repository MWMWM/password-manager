class Api::V1::PasswordEntriesController < Api::V1::BaseController
  before_action :find_password_entry, except: [:index, :create]

  def index
    render json: current_account.password_entries.
      to_json(only: [:id, :site_name, :username])
  end

  def show
    @entry.master_password = Account::HARDCODED_PASSWORD
    respond_with @entry.to_json(only: [:id, :site_name, :site_url, :username],
                                methods: [:decrypted_password])
  end

  def create
    @entry = current_account.password_entries.create(entry_params)
    render json: @entry.to_json(only: [:id, :site_name])
  end

  def update
    @entry.update(entry_params)
    respond_with @entry
  end

  def destroy
    respond_with @entry.destroy
  end

  def generate_sharing
    @entry.master_password = Account::HARDCODED_PASSWORD
    @entry.encrypt_sharing_password unless @entry.sharing_password_encrypted.present?
    render json: @entry.to_json(only: [:id], methods: [:generate_sharing_token])
  end

  def use_sharing
    @entry.sharing_token = params[:token]
    if @entry.valid_token?
      render json: @entry.to_json(methods: [:decrypted_shared_password])
    else
      render json: { error: 'invalid token' }
    end
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
