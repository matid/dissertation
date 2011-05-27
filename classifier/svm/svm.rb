require_relative "../base"

require "eluka"
require "colorize"

module Eluka
  class Model
    def reset
      @fv_test = Eluka::FeatureVectors.new(@features, false)
    end
  end
end

module Classifier
  class Svm < Base
    def run
      languages.each do |language|
        evaluate(language) do |score, tweets, training, test|
          classifier = Eluka::Model.new
        
          training.each do |tweet|
            classifier.add(Hash[*tweet.features.map { |feature| [feature, 1] }.flatten], tweet.sentiment.to_sym)
          end
        
          classifier.build
        
          test.each do |tweet|
            classifier.reset
            score.add(tweet, classifier.classify(Hash[*tweet.features.map { |feature| [feature, 1] }.flatten]))
          end
        end
      end
    end
  end
end