require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
  if request.user_agent && request.user_agent["Chrome"]
    "Chrome OK"
  else
    403 
  end
end