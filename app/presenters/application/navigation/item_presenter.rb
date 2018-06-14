class Application::Navigation::ItemPresenter < ApplicationPresenter
  def self.all_for(view_context)
    %i[ articles groups users albums contact ].map { |it| new(it, view_context: view_context) }
  end

  def active?
    h.current_page?(controller: absolute_controller_name, action: action_name)
  end

  def path
    h.url_for(controller: absolute_controller_name, action: action_name)
  end

  def title
    h.t("#{controller_name}.nav", default: h.t("activerecord.models.#{controller_name.to_s.singularize}.other"))
  end

private
  def controller_name
    to_sym
  end

  def absolute_controller_name
    "/#{controller_name}"
  end

  def action_name
    :index
  end
end