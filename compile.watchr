watch( '(data|haml|sass|coffee|js)/*' )  {|md| puts 'running `rake compile`...'; system('rake compile') }
