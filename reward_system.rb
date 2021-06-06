# frozen_string_literal: true


module RewardSystem
  # Opens up api end point.
  # Receives input file and present with calculated rewards
  class App
    def call(env)
      request = Rack::Request.new(env)
      case request.path
      when '/'
        Rack::Response.new('You can upload your files at /calculate_rewards').finish
      when '/calculate_rewards'
        if request.post?
          Rack::Response.new('{}', 200, { 'Content-Type' => 'application/json' }).finish
        else
          Rack::Response.new('Not found', 404).finish
        end
      else
        Rack::Response.new('Not found', 404).finish
      end
    end
  end
end
