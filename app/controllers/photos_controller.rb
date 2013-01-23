class PhotosController < ApplicationController
  def index
    @photos_by_month = Photo.all.group_by { |p| p.created_at.beginning_of_month }.sort.reverse # Array with a reversed order.
  end

  def geronimo
    @fetcher.synchronize! if @fetcher.remote_modified?

    redirect_to photos_path
  end
end
