require_relative "../base.rb"

require "ankusa"
require "ankusa/memory_storage"

Ankusa::STOPWORDS = ""
class Ankusa::TextHash
  def add_word(word)
    @word_count += 1
    key = word.intern
    store key, fetch(key, 0)+1
  end
end

module Classifier
  class Bayes < Base
    def run
      languages.each do |language|        
        evaluate(language) do |score, tweets, training, test|
          classifier = Ankusa::NaiveBayesClassifier.new Ankusa::MemoryStorage.new
        
          training.each do |tweet|
            classifier.train tweet.sentiment, tweet.to_s
          end
        
          test.each do |tweet|
            classifications = classifier.classifications tweet.to_s
            score.add(tweet, classifier.classify(tweet.to_s))
          end
        end
      end
    end

    def self.root
      Classifier.root + "bayes"
    end
  end
end