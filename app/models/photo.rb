class Photo < ActiveRecord::Base
  attr_accessible :cursor, :path, :rev, :url, :url_expires_at

  default_scope order('created_at DESC')

  class << self
    def current_cursor
      (Photo.count > 0) ? Photo.first.cursor : nil
    end

    def update_cursor(cursor)
      Photo.last.update_column(:cursor, cursor)
    end
  end

  def prolong_url!
    media_array = fetcher.url_from_path(path, :array)

    if url_expires_at.present?
      update_attributes(url_expires_at: media_array['expires'], url: media_array['url']) if url_expires_at < 2.hours.from_now
    else
      update_attributes(url_expires_at: media_array['expires'], url: media_array['url'])
    end
  end

  private

  def fetcher
    Dropbox::Sucker.new
  end
end
