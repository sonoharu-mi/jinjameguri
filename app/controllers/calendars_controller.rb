class CalendarsController < ApplicationController
  def index
    @calendar = Calendar.new
    @events = Calendar.all
    respond_to do |format|
      format.html
      format.json {
        render json: @events.map { |e|
          {
            id: e.id,
            title: "#{e.prefecture}#{e.city}：#{e.event}",
            start: e.start_date,
            end: e.end_date
          }
        }
      }
    end
  end

  def create
    @calendar = Calendar.new(calendar_params)
    if @calendar.save
      redirect_to calendars_path, notice: "登録しました"
    else
      @events = Calendar.all
    end
  end

  private
  def calendar_params
    params.require(:calendar).permit(:event, :prefecture, :city, :start_date, :end_date)
  end
end
