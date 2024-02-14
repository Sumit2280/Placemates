# require 'opportunities_controller.rb'

namespace :status do

  # every 1.day, at: '12:00 am' do
  # d = DateTime.now
  desc 'saying hi to cron'
    task :test => [ :environment ] do
       puts 'hi cron :)'
    end

end
