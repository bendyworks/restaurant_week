require 'sinatra'

get '/' do
  open 'index.html'
end

%w(site.css site.js assets/bendyworks.png).each do |asset|
  get "/#{asset}" do
    open asset
  end
end
