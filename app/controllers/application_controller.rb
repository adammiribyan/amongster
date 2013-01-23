class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_fetcher

  def set_fetcher
    @fetcher = Dropbox::Sucker.new
  end
end
