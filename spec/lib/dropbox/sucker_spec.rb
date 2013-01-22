require 'spec_helper'

module Dropbox
  describe Sucker do
    let(:sucker) { Dropbox::Sucker.new }

    describe '#client' do
      it 'returns DropboxClient object' do
        sucker.client.should be_a(DropboxClient)
      end

      it "returns my email address in client's account info hash" do
        sucker.client.account_info['email'].should eq 'adam.miribyan@gmail.com'
      end
    end

    describe '#remote_modified?' do
      it 'returns true if the remote state differs from the local one' do
        Photo.stubs(:current_cursor).returns(nil)
        sucker.remote_modified?(Photo.current_cursor).should be_true
      end
    end

    describe '#url_from_path', :url do
      let(:media_hash) { {'url' => 'https://dl.dropbox.com/0/view/wvxv1fw6on24qw7/file.png', 'expires' => 'Thu, 16 Sep 2011 01:01:25 +0000'} }

      before :each do
        sucker.client.stubs(:media).with('path_to_photo').returns(media_hash)
      end

      it 'returns a Hash with just url' do
        expect(sucker.url_from_path('path_to_photo')).to eq media_hash['url']
      end

      context 'when result_type is :array' do
        it 'returns a Hash with url and its expiration date' do
          expect(sucker.url_from_path('path_to_photo', :array)).to eq media_hash
        end
      end
    end
  end
end
