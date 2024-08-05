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
        date_time: params[:start_time].in_time_zone('Asia/Tokyo').iso8601,
        time_zone: 'Asia/Tokyo'
      },
      end: {
        date_time: params[:end_time].in_time_zone('Asia/Tokyo').iso8601,
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
    @client ||= Signet::OAuth2::Client.new(
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      token_credential_uri: 'https://oauth2.googleapis.com/token',
      redirect_uri: callback_url,
      grant_type: 'authorization_code'
    )
    if current_user.oauth_expires_at < Time.now
      @client.update!(
        grant_type: 'refresh_token',
        refresh_token: current_user.refresh_token
      )
      refresh_token
    else
      @client.update!(access_token: current_user.oauth_token)
    end
    @client
  end

  def refresh_token
    response = @client.fetch_access_token!
    current_user.update(
      oauth_token: response['access_token'],
      oauth_expires_at: Time.now + response['expires_in'].to_i.seconds
    )
  end

  def callback_url
    "#{request.base_url}/auth/google_oauth2/callback"
  end
end