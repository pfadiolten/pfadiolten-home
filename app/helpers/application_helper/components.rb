class ApplicationHelper::Components
  def initialize(view:)
    @view = view
  end

  def file_upload(url:)
    make('FileUpload', url: url, title: I18n.t('images.upload_images'))
  end

  def search_list(placeholder:, &block)
    make('SearchList', placeholder: placeholder, &block)
  end

  def user(user, &block)
    make 'User', user_props(user), &block
  end

  def user_list(users, &block)
    make 'UserList', users: users.map(&method(:user_props)), &block
  end

  def sortable(&block)
    make 'Sortable', &block
  end

  def gallery(images)
    make 'Gallery', images: (images.map do |image|
      {
        id: image.id,
        ratio: {
          width:  image.file.x1024.width,
          height: image.file.x1024.height,
        },
        src: {
          x128:  view.image_path(image.file.x128),
          x256:  view.image_path(image.file.x256),
          x512:  view.image_path(image.file.x512),
          x1024: view.image_path(image.file.x1024),
        },
      }
    end)
  end

  def make(name, props = {}, &block)
    if (classes = props.delete(:class))
      props[:className] = Array(classes).join(' ')
    end
    view.content_tag('div', nil, class: 'js-component', data: { component: {  name: name, props: props } }, &block)
  end

private
  attr_reader :view

  def user_props(user)
    {
      scout_name: user.scout_name,
      url:        view.user_path(user),
      avatar:     view.image_path(user.avatar.x256)
    }
  end
end