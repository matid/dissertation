require_relative "count"

class Score
  attr_accessor :total, :classified, :unclassified, :correct, :incorrect, :label, :classifier, :language
  
  def initialize(options = {})
    self.total = 0
    self.classified = Count.new
    self.unclassified = Count.new
    self.correct = Count.new
    self.incorrect = Count.new
    self.label = options.fetch(:label, "Score")
    self.classifier = options.fetch(:classifier, "unspecifed")
    self.language = options.fetch(:language, "unspecified")
  end
  
  def language
    {:en => "English", :es => "Spanish", :de => "German", :it => "Italian", :pl => "Polish"}[@language]
  end
  
  def +(score)
    Score.new.tap do |s|
      [:total, :classified, :unclassified, :correct, :incorrect].each do |counter|
        s.send(:"#{counter}=", self.send(counter) + score.send(counter))
      end
      s.label = @label
      s.classifier = @classifier
      s.language = @language
    end
  end
  
  def add(tweet, sentiment)
    self.total += 1
    
    if sentiment
      classified[tweet.sentiment] += 1
      
      if sentiment.to_sym == tweet.sentiment.to_sym
        correct[tweet.sentiment] += 1
      else
        incorrect[tweet.sentiment] += 1
      end
    else
      unclassified[tweet.sentiment] += 1
    end
    
    $stderr.print "."
    $stderr.print self.total if self.total % 100 == 0
  end
  
  def precision(sentiment = :total)
    correct[sentiment] * 100.to_f / classified[sentiment]
  end
  
  def recall(sentiment = :total)
    correct[sentiment] * 100.to_f / (classified[sentiment] + unclassified[sentiment])
  end
  
  def fscore(sentiment = :total)
    2 * precision(sentiment) * recall(sentiment) / (precision(sentiment) + recall(sentiment))
  end
  
  def latex
    %Q{#{language} & #{classifier} & #{"%0.2f" % precision(:positive)}\\% & #{"%0.2f" % precision(:negative)}\\% & #{"%0.2f" % precision}\\% & #{"%0.2f" % recall(:positive)}\\% & #{"%0.2f" % recall(:negative)}\\% & #{"%0.2f" % recall}\\% & #{"%0.2f" % fscore(:positive)}\\% & #{"%0.2f" % fscore(:negative)}\\% & #{"%0.2f" % fscore}\\% \\\\}
  end
  
  def summary 
%Q{==================
#{classifier}
==================
Language: #{language}
#{label}
------------------
Positive
------------------
Precision: #{"%0.2f" % precision(:positive)}%
Recall: #{"%0.2f" % recall(:positive)}%
Fscore: #{"%0.2f" % fscore(:positive)}%
------------------
Negative
------------------
Precision: #{"%0.2f" % precision(:negative)}%
Recall: #{"%0.2f" % recall(:negative)}%
Fscore: #{"%0.2f" % fscore(:negative)}%
------------------
Overall
------------------
Precision: #{"%0.2f" % precision}%
Recall: #{"%0.2f" % recall}%
Fscore: #{"%0.2f" % fscore}%
==================
#{latex}
==================

}
  end
  
  alias to_s summary
end