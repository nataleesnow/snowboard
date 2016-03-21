module LiftPassHelper
  def days_of_week
    html = ""
    1.times do |t|
      @presenter.days_of_week.each do |d|
        html += "<th>#{d}</th>"
      end
    end
    html.html_safe
  end

  def day_ride_cell(date)
    return day_cell(date) unless @presenter.ride_list[date]
    html = ""
    link_color = ''
    deer_class = 'deer_false'
    if date == @presenter.best_day[0]
      link_color = 'white'
      deer_class = 'deer_true'
    end
    html += "<td class='bottom-right-day #{deer_class}'>"
    unless date == @presenter.best_day[0]
      total_runs = @presenter.ride_list[date][:total_runs]
      total_vert = @presenter.ride_list[date][:total_vert].gsub!(/(\d+),\d+/, '\1k')
      html += "<div><strong><small>#{total_runs} <br /> #{total_vert}</small></strong></div>"
    end
    html += link_to(date.day, day_ride_path(@presenter.ride_list[date][:ride_id]), class: 'day', style: "color: #{link_color};")
    html += "</td>"
    html.html_safe
  end

  def day_cell(date)
    html = ""
    deer_class = 'deer_false'
    date.blank? ? display = "&nbsp;" : display = date.day
    html += "<td class='bottom-right-day #{deer_class}'>"
    html += "<span class='cal'>#{display}</span>"
    html += "</td>"
    html.html_safe
  end

end
