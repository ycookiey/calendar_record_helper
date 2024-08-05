class OmniauthController < ApplicationController
  def redirect
    redirect_to "/auth/#{params[:provider]}", allow_other_host: true
  end
end