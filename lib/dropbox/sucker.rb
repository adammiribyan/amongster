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
  # 4. Return the last modified date.
  class Sucker
    attr_reader :session, :client

    def initialize
      @session = DropboxSession.new(APP_KEY, APP_SECRET)
      @session.set_access_token(ACCESS_KEY, ACCESS_SECRET)
      @client = DropboxClient.new(@session, ACCESS_TYPE)
    end
  end
end
