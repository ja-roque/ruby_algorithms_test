require 'time'
require 'twitter'

MINS = (Time.now.utc.min + 5).to_i

# Check for file the stores word count
if File.exists?("word_count.txt")
	word_count = File.readlines('word_count.txt').first.to_i
	count_file = File.open("word_count.txt", "r+")
else
	count_file = File.new("word_count.txt", "w")
	word_count = 0
end

client = Twitter::Streaming::Client.new do | config |
	config.consumer_key				= 'dZqaetyAAoTqvhqbq7GEENFj3'
	config.consumer_secret			= 'Y6nuQ9aYxzLrD9MEPmvTlbxX6yfhCNeqJiTIC3ShrHPVos599n'
	config.access_token				= '195097254-EDkcmW8SzQLeA85bw7AhgVuz6BhM5hdXNgMrAeis'
	config.access_token_secret		= 'FKYy8DoVeSHhNn6Icjbs1LNAFuspIfgGjYCz7FSlEhYNU'
end

stop_words = ["i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", "yours", "yourself", "yourselves", "he", "him", "his", "himself", "she", "her", "hers", "herself", "it", "its", "itself", "they", "them", "their", "theirs", "themselves", "what", "which", "who", "whom", "this", "that", "these", "those", "am", "is", "are", "was", "were", "be", "been", "being", "have", "has", "had", "having", "do", "does", "did", "doing", "a", "an", "the", "and", "but", "if", "or", "because", "as", "until", "while", "of", "at", "by", "for", "with", "about", "against", "between", "into", "through", "during", "before", "after", "above", "below", "to", "from", "up", "down", "in", "out", "on", "off", "over", "under", "again", "further", "then", "once", "here", "there", "when", "where", "why", "how", "all", "any", "both", "each", "few", "more", "most", "other", "some", "such", "no", "nor", "not", "only", "own", "same", "so", "than", "too", "very", "s", "t", "can", "will", "just", "don", "should", "now"]

# Create hash to identify occurences
counts = Hash.new 0

# Loop through tweets to get the words
client.sample do |object|	
	if object.is_a?(Twitter::Tweet)
		break if object.created_at.min >= MINS
		object.text.split.map { | word |  counts[word] += 1 if !stop_words.include? word  }			
	end
end

word_count += counts.length
File.truncate(count_file, 0)
count_file.puts(word_count.to_s)

puts word_count

10.times do 
	curr_max = counts.key(counts.values.max)
	puts curr_max
	counts.delete(curr_max)
end