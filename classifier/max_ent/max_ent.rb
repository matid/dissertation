require_relative "../base"

require "maxent_string_classifier"

module Classifier
  class MaxEnt < Base
    def run
      languages.each do |language|
        evaluate(language) do |score, tweets, training, test|
          File.open(Classifier.root + "max_ent" + "data" + "#{language}" + "positive.txt", "w+") do |positive|
            File.open(Classifier.root + "max_ent" + "data" + "#{language}" + "negative.txt", "w+") do |negative|
              training.each do |tweet|
                positive << "#{tweet}\n\n" if tweet.positive?
                negative << "#{tweet}\n\n" if tweet.negative?
              end
            end
          end
      
          classifier = MaxentStringClassifier::Loader.train(Classifier.root + "max_ent" + "data" + "#{language}")
      
          test.each do |tweet| 
            score.add(tweet, classifier.classify(tweet.to_s).first.first)
          end
        end
      end
    end
  end
end