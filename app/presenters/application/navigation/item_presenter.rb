class Application::Navigation::ItemPresenter < ApplicationPresenter
  Item = Struct.new(:controller, :children)

  ITEMS = [
    Item.new(:articles),
    Item.new(:about_us, [
      Item.new(:users),
      Item.new(:groups),
      Item.new(:organizations),
    ]),
    Item.new(:albums),
    Item.new(:contact),
  ].freeze

  def self.all_for(view_context)
    ITEMS.map do |item|
      new(item, view_context: view_context)
    end
  end

  def active?
    h.current_page?(controller: absolute_controller_name, action: action_name)
  end

  def children?
    children.present? && children.any?
  end

  def children
    @_children ||= super&.map { |child| self.class.new(child, view_context: h) }
  end

  def path
    h.url_for(controller: absolute_controller_name, action: action_name)
  end

  def title
    h.t("#{controller_name}.nav", default: h.t("activerecord.models.#{controller_name.to_s.singularize}.other"))
  end

  def id
    "#{controller_name}Element"
  end

private
  def controller_name
    controller.to_sym
  end

  def absolute_controller_name
    "/#{controller_name}"
  end

  def action_name
    :index
  end
end