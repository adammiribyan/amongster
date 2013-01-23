namespace :photos do
  task :synchronize => :environment do
    fetcher = Dropbox::Sucker.new
    fetcher.synchronize!
  end
end
