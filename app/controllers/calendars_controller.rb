class CalendarsController < ApplicationController
  def index
    @events = Calendar.all
    respond_to do |format|
      format.html
      format.json
    end
  end
end
