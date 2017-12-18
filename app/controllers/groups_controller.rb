class GroupsController < ApplicationController
  before_action :load_group,
                except: %i[ new create index edit_order update_order ]

  before_action :load_groups,
                only: %i[ index edit_order update_order ]

  after_action :verify_policy_scoped,
               only: %i[ index edit_order update_order ]

  enforce_login! except: %i[ index show ]

  def index
  end

  def show
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    authorize @group
    @group.save
    respond_with @group
  end

  def edit
    @original_group = get_group
  end

  def update
    @original_group = get_group
    @group.update(group_params)
    respond_with @group
  end

  def edit_order
  end

  def update_order
    ids = order_params[:groups]&.map { |it| it[:id].to_i }
    if ids.present?
      not_found unless Group.all.all? { |it| ids.any? { |id| id == it.id } }

      Group.transaction do
        already_updated = []
        set_index = lambda do |group|
          index = ids.find_index { |id| id == group.id }
          if index != group.index
            if blocking_group = @groups.find_by(index: index)
              blocking_group.index =
                if group.index < 0
                  group.index - 1
                else
                  -1
                end
              blocking_group.save!
              group.index = index
              group.save!
              already_updated << group
              set_index.(blocking_group)
            else
              group.save!
              already_updated << group
            end
          end
        end

        @groups.each do |group|
          next if already_updated.any? { |it| it.id == group.id }
          set_index.(group)
        end
      end
    end

    self.success_message = I18n.t('flash.actions.update.success', resource_name: I18n.t('activerecord.attributes.group.index'))
    redirect_to groups_path
  end

  def destroy
    @group.destroy
    respond_with @group
  end

protected
  def load_group
    @group = get_group || not_found
    authorize @group
  end

  def load_groups
    @groups = policy_scope(Group)
    authorize @groups
  end

  def get_group
    Group.find_by('LOWER(abbreviation) = ?', params[:abbreviation]&.downcase)
  end

private
  def group_params
    params.require(:group).permit(
      :name,
      :abbreviation,
      :what,
      :when,
      :who
    )
  end

  def order_params
    params.permit(groups: %i[ id ])
  end
end
