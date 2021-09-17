class ApplicationResponder < ActionController::Responder
  include Responders::HttpCacheResponder
  include Responders::FlashResponder

  def initialize *args
    super
  end

  def resource_name
    name = super
    # Fixes a bug where the name is the hash of all the resources translations defined in the locale file.
    # Not really sure if it's a bug or just the way it's supposed to work, and we're using the locales wrong.
    # (daniel-va, 2021.09.17)
    return name[:one] if name.is_a?(Hash) && name.has_key?(:one)
    name
  end
end
