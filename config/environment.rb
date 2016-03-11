# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load env
local_env = File.join(Rails.root, 'config', 'local_env.rb')
load(local_env) if File.exists?(local_env) && Rails.env.production?

# Initialize the Rails application.
Rails.application.initialize!
