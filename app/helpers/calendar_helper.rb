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

        event, day = args[:event], args[:day]

        html = %(<a class="time" href="/appointments/#{event.id}/edit" title="#{h(event.start_at.strftime('%d. %b %y %R') + ' - ' + event.end_at.strftime('%d. %b %y %R'))}">)
        html << %(<span>#{h(event.start_at.strftime('%R'))}</span>) << %(&nbsp;&nbsp;)
        html << %(#{h(event.note)}</a>)
        html



    end
  end
end
