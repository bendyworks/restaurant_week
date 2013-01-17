desc 'Compile all the things'
task :compile => 'compile:all'

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

directory 'tmp/js'

namespace :compile do

  task :all => ['site.css', 'site.js', :html]

  file 'site.css' do
    sh 'sass sass/application.scss site.css'
  end

  file 'site.js' => ['js/semicolon.js'] + ALL_JS do
    sh "cat #{ALL_JS.join(' js/semicolon.js ')} > site.js"
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
