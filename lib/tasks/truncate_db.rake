namespace :db do

  desc "Truncate all existing data"
  task :truncate => :environment do
    DatabaseCleaner.clean_with :truncation
  end

end