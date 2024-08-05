class CalendarHelperController < ApplicationController
  def new
  end

  def create
    @title = params[:title]
    @start_time = params[:start_time]
    @end_time = params[:end_time]

    flash[:notice] = 'イベントがGoogleカレンダーに追加されました'
    redirect_to calendar_helper_new_path
  end
end