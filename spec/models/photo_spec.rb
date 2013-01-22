require 'spec_helper'

describe Photo do
  describe '.current_cursor' do
    it 'returns the latest added photo cursor' do
      2.times { |i| FactoryGirl.create(:photo, cursor: "blabla-#{i}") }
      Photo.current_cursor.should eq 'blabla-0'
    end
  end

  describe '#prolong_url!' do
    let(:photo) { FactoryGirl.create(:photo, path: 'path_to_photo', url_expires_at: 1.hour.ago, url: 'expired_url') }

    before :each do
      Dropbox::Sucker.any_instance.stubs(:url_from_path).with(photo.path, :array).returns({
        'url' => 'new_url',
        'expires' => 4.hours.from_now.to_s
      })
    end

    it "updates photo url if it's going to expire soon" do
      photo.prolong_url!
      photo.url.should eq 'new_url'
    end
  end
end
