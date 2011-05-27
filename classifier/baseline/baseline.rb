require_relative "../base"

module Classifier
  class Baseline < Base
    def initialize
      self.folds = 1
      super
    end

    def run
      languages.each do |language|
        evaluate(language) do |score, tweets, training, test|
          keywords = {:positive => File.read(Baseline.root + "dictionary" + "positive" + "#{language}-expanded").split,
                      :negative => File.read(Baseline.root + "dictionary" + "negative" + "#{language}-expanded").split}
        
          tweets.each do |tweet|
            positivity = tweet.to_s.split(/[^\w\d]/).map { |word| keywords[:positive].include?(word) ? 1 : 0 }.sum
            negativity = tweet.to_s.split(/[^\w\d]/).map { |word| keywords[:negative].include?(word) ? 1 : 0 }.sum
        
            sentiment = if positivity > negativity
              :positive
            elsif negativity > positivity
              :negative
            end
                    
            score.add(tweet, sentiment)
          end
        end
      end
    end

    def self.root
      Classifier.root + "baseline"
    end
  end
end