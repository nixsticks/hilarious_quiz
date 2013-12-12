require 'bundler'
Bundler.require

Dir('./lib').glob('.rb') do |file|
  require file
end

module Quiz
  class App < Sinatra::Application
    get '/' do
      
    end
  end
end