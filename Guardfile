guard 'coffeescript', input: 'coffee', output: 'tmp'
guard 'sass', :input => 'sass', :output => 'css'

guard 'haml', output: '.', input: 'haml' do
  watch(/^haml\/.+(\.html\.haml)/)
end

guard 'webrick'

guard 'sprockets', destination: 'js', minify: true do
  watch %r{tmp/(.*\.js)}
end
