require 'rack/reloader'
require_relative 'reward_system'

use Rack::Reloader
use Rack::Auth::Basic do |_username, password|
  password == 'password'
end
run RewardSystem::App.new
