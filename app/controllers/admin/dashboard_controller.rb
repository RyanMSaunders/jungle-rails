class Admin::DashboardController < ApplicationController
  before_action :authenticate

  def show
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
  

end
