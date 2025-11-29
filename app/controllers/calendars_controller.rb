class CalendarsController < ApplicationController
  def index
    @events = Calendar.all
    respond_to do |format|
      format.html
      format.json {
        render json: @events.map { |e|
          {
          id: e.id,
          event: "#{e.prefecture}#{e.city}：#{e.event}",
          start: e.start_date,
          end: e.end_date
          }
        }
      }
    end
  end
end
