class UsersController < ApplicationController
# callbacks
  before_action :load_user,
                except: %i[ index new create forgot_password send_recover_token ]

  enforce_login! except: %i[ index show new create forgot_password send_recover_token ]

# actions
  def index
    @users = policy_scope(User)
    authorize @users
  end

  def show
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    raise (user_params(allow_password: true)).to_s

    @user = User.new(user_params(allow_password: true))
    authorize @user
    @user.save
    respond_with @user
  end

  def edit
    @original_user = get_user
    authorize @original_user
  end

  def update
    @original_user = get_user
    @user.update(user_params)
    respond_with @user
  end

  def edit_password
  end

  def update_password
    sign_in(@user, bypass: true) unless @user.errors.any?
    respond_with @user, action: 'edit_password'
  end

  def edit_admin
  end

  def update_admin
    @user.update(is_admin: !@user.admin?)
    respond_with @user, action: 'edit_admin'
  end

  def destroy
    @user.destroy
    respond_with @user, action: 'edit'
  end

  def forgot_password
    @user = User.new
    authorize @user
  end

  def send_recover_token
    scout_name = params.dig(:user, :scout_name)
    @user = User.find_by_scout_name(scout_name)
    authorize User, @user
    # TODO
    if @user.nil?
      respond_to do |format|
        self.failure_message =I18n.t('errors.messages.unknown_user', name: scout_name)
        format.html { redirect_to '/' }
      end
    else
      respond_to do |format|
        self.failure_message =I18n.t('errors.messages.unknown_user', name: scout_name)
        format.html { redirect_to '/' }
      end
    end
  end

# helpers
protected
  def load_user
    @user = get_user || not_found
    authorize @user
  end

  def get_user
    User.find_by('LOWER(scout_name) = ?', params[:scout_name]&.downcase)
  end

# params
private
  def user_params(allow_password: false)
    params = self.params.require(:user).permit(
      :first_name, :last_name,
      :scout_name,
      :description,
      :group_id,
      :avatar,
      :remove_avatar
    )

    if allow_password
      params.permit(
        :password,
        :password_confirmation
      )
    else
      params
    end
  end

  def user_password_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end
end
