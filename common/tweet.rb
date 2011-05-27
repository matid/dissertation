# encoding: utf-8

class Tweet < ActiveRecord::Base
  validates :status_id, :uniqueness => true
  
  scope :training, where("`text` NOT LIKE '%:p%'").where("`text` NOT LIKE '%RT %'")
  
  scope :positive, where(:sentiment => "positive")
  scope :negative, where(:sentiment => "negative")
  
  def self.reductions
    {%r{\:\)|\:\-\)|\: \)|\:d|=\)|\:\(|\:\-\(|\: \(|} => "",
     %r{@\w+} => "USERNAME",
     %r{(?i)\b((?:[a-z][\w-]+:(?:/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))} => "URL",
     %r{(\w)\1+} => '\1',
     %r{\n} => ""}
  end

  def self.parse(tweet, options = {})
    self.create({:status_id => tweet.id_str,
                 :language => tweet.iso_language_code,
                 :text => tweet.text,
                 :json => tweet.to_json}.merge(options))
  end

  def to_s; self.class.reductions.inject(text.downcase) { |text, reduction| text.gsub(reduction.first, reduction.last) } end
  
  def features
    to_s.split
  end
end