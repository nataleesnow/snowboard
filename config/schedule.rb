# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
#
set :output, "../log/cron_log.log"

every 1.day do
 rake "import:transactions"
end

# Learn more: http://github.com/javan/whenever