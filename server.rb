require 'sinatra'

set :public_folder, File.dirname(__FILE__)

get '/' do
  open 'index.html'
end
