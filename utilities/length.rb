require_relative "../init"
require_relative "../common/tweet.rb"

words = 0
characters = 0

Tweet.find_each do |tweet|  
  words += tweet.text.split.size
  characters += tweet.text.length
end

puts "Average \# of words: #{words / Tweet.count}"
puts "Average \# of characters: #{characters / Tweet.count}"