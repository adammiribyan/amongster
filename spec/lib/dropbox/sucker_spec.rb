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
  end
end
