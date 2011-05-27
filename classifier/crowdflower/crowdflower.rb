require_relative "../base"

require "csv"

module Classifier
  class Crowdflower < Base
    def initialize
      self.limit = 200
      super
    end
  
    def run
      languages.each do |language|
        puts "#{language}"
        puts "---"
      
        tweets = self.tweets.training.where(:language => language)

        positive = tweets.positive
        negative = tweets.negative

        tweets = positive + negative
      
        csv = CSV.generate do |csv|
          csv << ["status_id", "language", "sentiment", "text"]
          tweets.each do |tweet|
            csv << [tweet.status_id, tweet.language, tweet.sentiment, tweet.text.gsub(%r{\:\)|\:\-\)|\: \)|\:d|=\)|\:\(|\:\-\(|\: \(|}i, "")]
          end
        end
      
        puts csv
      end
    end

    def self.root
      Classifier.root + "baseline"
    end
  end
end