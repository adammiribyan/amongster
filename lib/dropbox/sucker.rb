require 'dropbox_sdk'

module Dropbox
  APP_KEY = 'm27o41c02uhq89g'
  APP_SECRET = 'a8xjssljeokwatf'

  ACCESS_KEY = 'au0syi10qwfufau'
  ACCESS_SECRET = 'o50jot5m9xfl9h8'
  ACCESS_TYPE = :app_folder

  # 1. Check for updates.
  # 2. Download new files.
  # 3. Remove deleted files from the db.
  class Sucker
    attr_reader :session, :client

    def initialize
      @session = DropboxSession.new(APP_KEY, APP_SECRET)
      @session.set_access_token(ACCESS_KEY, ACCESS_SECRET)
      @client = DropboxClient.new(@session, ACCESS_TYPE)
    end

    def modified?(current_cursor)
      delta = @client.delta(current_cursor).to_options
      delta[:entries].any?
    end

    def synchronize!
    end

    private

    def get_new_files
    end

    def delete_old_files
    end
  end
end
