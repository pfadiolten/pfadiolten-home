class ApplicationHelper::Icons
  attr_reader :create

  def initialize(create)
    @create = create
  end

  class << self
    def icon(**args)
      args.each_pair do |name, args|
        define_method name do
          create.(*args)
        end
      end
    end
  end

  # actions
  icon new:     %w[ fas plus ],
       edit:    %w[ fas edit ],
       destroy: %w[ fas trash-alt ]

  # interaction
  icon expand: %w[ fas angle-down ],
       shrink: %w[ fas angle-up ],
       order:  %w[ fas sort ],
       close:  %w[ fas times ]

  # state
  icon alert:   %w[ fas exclamation-circle ],
       success: %w[ fas check ],
       failure: %w[ fas times ],
       pinned:  %w[ fas thumbtack ]

  # objects
  icon images:      %w[ fas images ],
       time:        %w[ fas clock ],
       date:        %w[ far calendar-alt ],
       location:    %w[ fas map-marker-alt ],
       download:    %w[ fas file-download ],
       permissions: %w[ fas user-check ]

  # account
  icon mail:     %w[ fas envelope ],
       profile:  %w[ fas user-circle ],
       sign_in:  %w[ fas sign-in-alt ],
       sign_out: %w[ fas sign-out-alt ],
       password: %w[ fas key ],
       admin:    %w[ fas bolt ]

  # logos
  icon facebook:  %w[ fab facebook ],
       instagram: %w[ fab instagram ],
       github:    %w[ fab github ]

  icon event_activity: %w[ fas rocket ],
       event_camp:     %w[ fas map-signs ]
end