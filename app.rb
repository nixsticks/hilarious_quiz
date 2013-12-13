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
      @results = {
        :ashley => ["You are Ashley!", "You like doges and hang out on meat-space.", "You are an internet wizard.", "You are awesome."],
        :blake => ["You are Blake!", "You are a world traveler who surfs a lot.", "You are known for eating entire avo-cadoes.", "You are awesome."],
        :blashley => ["A WILD BLASHLEY APPEARS!", "You are a rare blend of our two instructors.", "Perhaps you like doges that eat avocadoes.", "Or perhaps doges on surfboards."]
      }
    end

    get '/' do
      erb :quiz
    end

    post '/result' do
      result = params.values.map {|value| value.to_i}.reduce(:+)
      if result < 0
        answer = :ashley
      elsif result > 0
        answer = :blake
      else
        answer = :blashley
      end
      @header = @results[answer].first
      @message = @results[answer][1..-1]
      @image = "#{answer.to_sym}.jpg"
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