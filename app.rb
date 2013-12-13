require 'bundler'
Bundler.require

Dir.glob('./lib/*.rb') do |file|
  require file
end

module Quiz
  class App < Sinatra::Application
    before do
      @questions = get_questions
      @options = get_options
    end

    get '/' do
      erb :quiz
    end

    post '/result' do
      result = params.values.map {|value| value.to_i}.reduce(:+)
      if result < 0
        @message = "You are Ashley!
        You are fond of doges and meatspace.
        You are awesome."
        @image = "ashley_image"
      elsif result > 0
        @message = "You are Blake!
        You are fond of avocadoes.
        You are awesome."
        @image = "blake_image"
      else
        @message = "A WILD BLASHLEY APPEARS!

        You are a rare blend of "
        @image = "blashley_image"
      end
      erb :result
    end

    helpers do
      def get_questions
        all = File.read("./lib/questions.txt").split("\n\n")
        all.map {|question| question.gsub(/\- [\w\W]*/, "")}
      end

      def get_options
        all = File.read("./lib/questions.txt").split("\n\n")
        all.map do |section|
          section.scan(/\- (.*)/).flatten
        end
      end
    end
  end
end