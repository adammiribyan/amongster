class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def geronimo
    @fetcher.synchronize! if @fetcher.remote_modified?

    redirect_to photos_path
  end
end
