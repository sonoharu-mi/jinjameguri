class CalendarsController < ApplicationController
  def index
    @calendars = Calendar.all
    respond_to do |format|
      format.html
      format.json{ render json: @calendars }
    end
  end
end
