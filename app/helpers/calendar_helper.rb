module CalendarHelper


  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => "<h4>" + I18n.localize(@shown_month, :format => "%B %Y") + "</h4>",
      :previous_month_text => month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month),
      :use_all_day => true
    }
  end

  def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      if current_user.id.eql?(args[:event].user_id)
        event, day, options = args[:event], args[:day], args[:options]
        html = %(<a href="/appointments/#{event.id}/edit" title="#{h(event.note)}">)
        html << display_event_time(event, day)
        html << %(#{h(event.note)}</a>)
        html

      else
        event, day = args[:event], args[:day]
        html = %(#{h(event.user_id)})
        html << %(#{h(options)})

      end

    end
  end
end
