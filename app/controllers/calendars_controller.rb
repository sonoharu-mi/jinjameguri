class CalendarsController < ApplicationController
  def index
    @calendar_new = Calendar.new
    @events = Calendar.all
    respond_to do |format|
      format.html
      format.json {
        render json: @events.map { |e|
          {
            id: e.id,
            title: "#{e.prefecture}#{e.city}：#{e.event}",
            start: e.start_date,
            end: e.end_date,
            extendedProps: {
              editable: e.user_id == current_user.id
            }
          }
        }
      }
    end
  end

  def create
    @calendar_new = current_user.calendars.build(calendar_params)
    if @calendar_new.save
      redirect_to calendars_path, notice: "登録しました"
    else
      @events = Calendar.all
      recder :index
    end
  end

  def destroy
    @calendar = current_user.calendars.find(params[:id])
    @calendar.destroy
    redirect_to calendars_path, notice: "削除しました"
  end

  private
  def calendar_params
    params.require(:calendar).permit(:event, :prefecture, :city, :start_date, :end_date)
  end
end
