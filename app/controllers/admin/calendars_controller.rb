class Admin::CalendarsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @calendars = Calendar.all.order(created_at: :desc)
  end

  def destroy
    calendar = Calendar.find(params[:id])
    calendar.destroy
    redirect_to admin_calendars_path,  notice: "行事予定を削除しました。"
  end
end
