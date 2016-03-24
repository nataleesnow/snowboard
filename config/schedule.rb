# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
#
set :output, "log/cron_log.log"
set :environment, "development"

every 1.day, :at => '5:00 pm' do
 rake "import:transactions"
end

# Learn more: http://github.com/javan/whenever
