require_relative "../init"
require_relative "../common/tweet.rb"

require "twitter"

module Crawler
  class Base
    def initialize
      @languages = [:en, :es, :de, :it, :pl]
    end

    def run
      @languages.each do |language|
        Twitter::Search.new.language(language).positive.each do |tweet|
          Tweet.parse(tweet, :sentiment => "positive")
        end

        Twitter::Search.new.language(language).negative.each do |tweet|
          Tweet.parse(tweet, :sentiment => "negative")
        end
      end
    end
  end
end

loop do
  print "."
  Crawler::Base.new.run
  sleep 10*60
end
