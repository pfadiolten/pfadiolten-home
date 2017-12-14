Rails.application.instance_exec do
  # Use the responders controller from the responders gem
  config.app_generators.scaffold_controller :responders_controller

# replace the :notice and :alert keys
  config.responders.flash_keys = [ :success, :failure ]
end

