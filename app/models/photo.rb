class Photo < ActiveRecord::Base
  attr_accessible :cursor, :path, :rev

  default_scope order('created_at DESC')

  class << self
    def current_cursor
      (Photo.count > 0) ? Photo.last.cursor : nil
    end

    def update_cursor(cursor)
      Photo.last.update_column(:cursor, cursor)
    end
  end
end
