class UsersController < ApplicationController
# callbacks
  before_action :load_user,
                except: %i[ index new create forgot_password send_recover_token ]

  enforce_login! except: %i[ index show new create forgot_password send_recover_token ]


# actions
  def index
    @users = present_all policy_scope(User.all)
    authorize @users
  end

  def show
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
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
    head 501
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
  def user_params
    p = params.require(:user).permit(
      :first_name, :last_name,
      :scout_name,
      :description,
      :group_id,
      :avatar,
      :remove_avatar,
      stored_avatar_attributes: [
        :id,
        :_destroy,
        :file,
      ]
    )

    # TODO remove after migrating to ActiveStorage
    p.tap do |attrs|
      avatar_attrs = attrs[:stored_avatar_attributes]
      avatar_attrs[:old_file] = avatar_attrs[:file]
    end
  end

  def user_password_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end
end
