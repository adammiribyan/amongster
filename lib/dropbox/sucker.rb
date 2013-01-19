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
      Photo.update_cursor(current_remote_cursor)
    end

    def get_new_files(local_revs = Photo.pluck(:rev))
      new_revs = remote_revs - local_revs

      @client.metadata('/')['contents'].each do |file|
        if new_revs.include?(file['rev'])
          Photo.create do |photo|
            photo.rev  = file['rev']
            photo.path = file['path']
            photo.url  = @client.media(file['path'])['url']
          end
        end
      end
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
