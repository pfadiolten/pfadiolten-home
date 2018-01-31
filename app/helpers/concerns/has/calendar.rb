module Has::Calendar
  def calendar_values
    @calendar ||= OpenStruct.new(
      params: OpenStruct.new(
        view: t('simple_calendar.params.view'),
        start_date: t('simple_calendar.params.start_date')
      ),

      views: OpenStruct.new(
        month: t('simple_calendar.views.month'),
        week:  t('simple_calendar.views.week'),
        day:   t('simple_calendar.views.day')
      )
    )
  end
end