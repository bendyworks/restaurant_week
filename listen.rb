#guard 'coffeescript', input: 'coffee', output: 'tmp'
#guard 'sass', :input => 'sass', :output => 'css'

#guard 'haml', output: '.', input: 'haml' do
  #watch(/^haml\/.+(\.html\.haml)/)
#end

#guard 'webrick'

#guard 'sprockets', destination: 'js', minify: true do
  #watch %r{tmp/(.*\.js)}
#end

require 'listen'
require 'fileutils'
require 'coffee-script'

coffeescripts = Dir['coffee/*']
sasses = Dir['sass/*']
hamls = Dir['haml/*']

coffeescript = Listen.to('coffee')
sass = Listen.to('sass')
haml = Listen.to('haml')

coffeescript.change do |modified, added, removed|
  puts 'COFFEESCRIPT'
  puts "  modified: #{modified.join(', ')}"
  puts "  added: #{added.join(', ')}"
  puts "  deleted: #{removed.join(', ')}"

  dest = ->(orig) { orig.sub(/coffee\/(.*)\.coffee/, 'tmp/\1.js') }
  removed.each do |remove|
    FileUtils.rm dest[remove]
    coffeescripts.delete(remove)
  end


  added.each do |add|
    coffeescripts << add
  end

  (added + modified).each do |filename|
    File.open(dest[filename], 'w') do |f|
      f.write ::CoffeeScript.compile(File.read(filename))
    end
  end

  File.open('js/application.js', 'w') do |f|
    f.puts "'use strict';"
    f.puts open('vendor/zepto.js').read
    f.puts open('vendor/doT.min.js').read
    f.puts open('tmp/restaurants.js').read
    f.puts open('tmp/infoWindow.js').read
    f.puts open('tmp/app.js').read
  end
end

sass.change do |modified, added, removed|
  puts 'changed sass'
end

haml.change do |modified, added, removed|
  puts 'changed haml'
end

coffeescript.start(false)
sass.start(false)
haml.start
