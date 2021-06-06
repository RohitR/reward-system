# frozen_string_literal: true

require 'securerandom'
require 'singleton'
Dir[File.dirname(__FILE__) + '/reward_system/*.rb'].each { |file| require file }
require 'json'

module RewardSystem
  REPO = Repository.instance
  # Opens up api end point.
  # Receives input file and present with calculated rewards
  class App
    def call(env)
      request = Rack::Request.new(env)
      case request.path
      when '/'
        Rack::Response.new('Upload your files at /calculate_rewards').finish
      when '/calculate_rewards'
        resp = calculate_rewards(request)
        REPO.flush_all && resp.finish
      else
        Rack::Response.new('Not found', 404).finish
      end
    end

    def calculate_rewards(request)
      if request.post?
        file = request.params['file'] && request.params['file'][:tempfile]
        raise Errors::FileNotFound unless file

        json_response(RewardSystem::RewardCalculator.run(file))
      else
        Rack::Response.new('Not found', 404)
      end
    rescue StandardError => e
      Rack::Response.new(e.message, 422)
    end

    def json_response(resp)
      Rack::Response.new(
        resp.to_json, 200,
        'Content-Type' => 'application/json'
      )
    end
  end
end
