require 'sinatra'

$stdout.sync = true  # Add this line

set :bind, '0.0.0.0'

get '/' do
  puts "Received request with User-Agent: #{request.user_agent.inspect}"
  if request.user_agent && request.user_agent.include?("Chrome")
    "Chrome OK"
  else
    403 
  end
end