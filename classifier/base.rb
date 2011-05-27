require_relative "../common/tweet.rb"
require_relative "../common/score.rb"

module Classifier
  class Base
    attr_accessor :languages, :tweets, :limit, :folds
    
    def initialize
      self.languages ||= [:pl]
      self.limit ||= 150000
      self.folds ||= 10
      self.tweets ||= Tweet.order("random()").limit(self.limit / 2)
    end
    
    def evaluate(language, &block)
      tweets = self.tweets.where(:language => language)
      
      positive = tweets.positive
      negative = tweets.negative
      
      tweets = positive + negative
      
      average = Score.new(:classifier => self.class.name, :language => language, :label => "Average")
      
      folds.times do |fold|
        score = Score.new(:classifier => self.class.name, :language => language, :label => "Trial #{fold+1}")
        
        test = (positive[range(fold)] + negative[range(fold)]).shuffle
        training = tweets - test
        
        yield score, tweets, training, test
        
        average += score
      end
      
      puts average.summary
    end
    
  private
    
    def range(fold)
      (fold * limit / (2 * folds))...((fold + 1) * limit / (2 * folds))
    end
  end

  def self.root
    Dissertation.root + "classifier"
  end
end
