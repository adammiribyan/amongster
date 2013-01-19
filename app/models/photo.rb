class Photo < ActiveRecord::Base
  attr_accessible :cursor, :path, :rev
end
