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
  end
end

# if remote_folder.modified?
#   remote_folder.synchronize!
# end
