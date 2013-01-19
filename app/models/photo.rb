class Photo < ActiveRecord::Base
  attr_accessible :cursor, :path, :rev

  class << self
    def current_cursor
      (Photo.count > 0) ? Photo.last.cursor : nil
    end
  end
end
