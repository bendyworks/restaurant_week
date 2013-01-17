require 'sinatra'

get '/' do
  open 'index.html'
end

set :public_folder, File.dirname(__FILE__)
