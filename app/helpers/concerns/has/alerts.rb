module Has::Alerts
  extend ActiveSupport::Concern

  def success_message=(message)
    alert_messages_for(:success) << message
  end

  def failure_message=(message)
    alert_messages_for(:failure) << message
  end

  def success_messages
    alert_messages_for(:success).clone
  end

  def failure_messages
    alert_messages_for(:failure).clone
  end

private
  def alert_messages_for(phase)
    flash.now[phase] =
      if existing = flash.now[phase]
        if existing.is_a?(Array)
          existing
        else
          [ existing ]
        end
      else
        []
      end
  end
end