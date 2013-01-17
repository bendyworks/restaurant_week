require 'yaml'
require 'active_support/core_ext/object'

desc 'Compile all the things'
task :compile => 'compile:all'

SASS_FILES = FileList['sass/*.{sass,scss}']

COFFEE_FILES = FileList['coffee/*.coffee']
JS_FILES = COFFEE_FILES.pathmap('tmp/js/%n.js')

ALL_JS = %w(js/strict.js
            js/zepto.js
            js/doT.js
            js/restaurants.js
            tmp/js/infoWindow.js
            tmp/js/app.js
           )

HAML_FILES = FileList['haml/*.haml']
HTML_FILES = HAML_FILES.pathmap('%n.html')

RESTAURANT_FILES = FileList['data/restaurants/*.yml']

directory 'tmp/js'

namespace :compile do

  task :all => ['site.css', 'site.js', :html]

  file 'site.css' => SASS_FILES do
    sh 'sass sass/application.scss site.css'
  end

  file 'site.js' => ['js/semicolon.js'] + ALL_JS do
    sh "cat #{ALL_JS.join(' js/semicolon.js ')} > site.js"
  end

  file 'js/restaurants.js' => RESTAURANT_FILES do
    yml = RESTAURANT_FILES.to_a.map do |fname|
      {
        basename: File.basename(fname, '.yml'),
        data: YAML::load_file(fname)
      }
    end

    puts 'compiling restaurants'
    File.open('js/restaurants.js', 'w') do |f|
      f.puts "window.restaurants = #{yml.to_json};"
    end
  end

  JS_FILES.zip(COFFEE_FILES).each do |target, source|
    file target => ['tmp/js', source] do
      sh "coffee -b -p -c #{source} > #{target}"
    end
  end

  task :coffee => JS_FILES

  HTML_FILES.zip(HAML_FILES).each do |target, source|
    file target => source do
      sh "haml #{source} #{target}"
    end
  end

  task :html => HTML_FILES
end
