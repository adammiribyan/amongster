require 'dropbox_sdk'

module Dropbox
  APP_KEY = 'm27o41c02uhq89g'
  APP_SECRET = 'a8xjssljeokwatf'

  ACCESS_KEY = 'au0syi10qwfufau'
  ACCESS_SECRET = 'o50jot5m9xfl9h8'
  ACCESS_TYPE = :app_folder

  class Sucker
    attr_reader :session, :client

    def initialize
      @session = DropboxSession.new(APP_KEY, APP_SECRET)
      @session.set_access_token(ACCESS_KEY, ACCESS_SECRET)
      @client = DropboxClient.new(@session, ACCESS_TYPE)
    end

    def remote_modified?(cursor = Photo.current_cursor)
      delta = @client.delta(cursor)
      delta['entries'].any?
    end

    def synchronize!
      get_new_files
      clear_deleted_files
      Photo.update_cursor(current_remote_cursor)
      Photo.all.each { |photo| photo.prolong_url! }
    end

    def get_new_files(local_revs = Photo.pluck(:rev))
      new_revs = remote_revs - local_revs

      @client.metadata('/')['contents'].each do |file|
        if new_revs.include?(file['rev'])
          Photo.create do |photo|
            photo.rev  = file['rev']
            photo.path = file['path']
            photo.url  = url_from_path(file['path'])
          end
        end
      end
    end

    def clear_deleted_files
      Photo.all.each do |photo|
        photo.destroy if @client.metadata(photo.path)['is_deleted'].to_s == 'true'
      end
    end

    def url_from_path(path, result_type = :url)
      media_hash = @client.media(path)
      result_type.to_s == 'url' ? media_hash['url'] : media_hash
    end

    private

    def current_remote_cursor
      @client.delta['cursor']
    end

    def remote_revs
      revs = []
      @client.metadata('/')['contents'].each do |file|
        revs << file['rev']
      end

      revs
    end
  end
end
