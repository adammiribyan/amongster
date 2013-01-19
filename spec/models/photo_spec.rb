require 'spec_helper'

describe Photo do
  describe '.current_cursor' do
    it 'returns the latest added photo cursor' do
      2.times { |i| FactoryGirl.create(:photo, cursor: "blabla-#{i}") }
      Photo.current_cursor.should eq 'blabla-1'
    end
  end
end
