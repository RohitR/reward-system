require 'rack/reloader'
require_relative 'reward_system'

use Rack::Reloader
run RewardSystem::App.new
