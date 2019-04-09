class EditorInput < SimpleForm::Inputs::Base
  include ComponentInput

  def input(wrapper_options = nil)
    make 'EditorInput', wrapper_options
  end

  def props(options)
    {
      uploadURL:       template.rails_direct_uploads_url,
      blobURLTemplate: template.rails_service_blob_url(':signed_id', ':filename')
    }
  end

  def value
    object.public_send(attribute_name)
  end
end