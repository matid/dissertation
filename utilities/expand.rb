require_relative "../init"

sentiment = ARGV.first.try(:to_sym) || :positive

keywords = File.read(Dissertation.root + "classifier" + "baseline" + "dictionary" + "#{sentiment}" + "en").split
words = File.read("/usr/share/dict/words").split

count = 0
words.each do |word|
  count += 1
  $stderr.puts "#{count}/#{words.count}" if count % 100 == 0
  if keywords.any? { |keyword| word.downcase.match(keyword) }
    puts word.downcase 
  end
end