require 'google/apis/calendar_v3'

class CalendarHelperController < ApplicationController
  def new
  end

  def create
    if current_user.nil?
      redirect_to '/auth/google_oauth2'
      return
    end

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    event = Google::Apis::CalendarV3::Event.new(
      summary: params[:title],
      start: {
        date_time: params[:start_time].to_datetime.rfc3339,
        time_zone: 'Asia/Tokyo'
      },
      end: {
        date_time: params[:end_time].to_datetime.rfc3339,
        time_zone: 'Asia/Tokyo'
      }
    )

    service.insert_event('primary', event)

    flash[:notice] = 'イベントがGoogleカレンダーに追加されました'
    redirect_to calendar_helper_new_path
  rescue Google::Apis::AuthorizationError => e
    Rails.logger.error "Authorization Error: #{e.message}"
    redirect_to '/auth/google_oauth2'
  rescue => e
    Rails.logger.error "Error: #{e.message}"
    flash[:error] = 'エラーが発生しました。もう一度お試しください。'
    redirect_to calendar_helper_new_path
  end

  private

  def client
    Signet::OAuth2::Client.new(
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      access_token: current_user.oauth_token,
      refresh_token: current_user.refresh_token,
      grant_type: 'refresh_token',
      expires_at: current_user.oauth_expires_at.to_i
    )
  end
end