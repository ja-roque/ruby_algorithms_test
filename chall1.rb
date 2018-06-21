file_lines = File.readlines('chall1file.txt')

BOOLEAN_HASH = {
'yes' => true,
'true' => true,
'on'  => true,
'no'  => false,
'false' => false,
'off' => false
}



def get_type(string)
	string = string.split('#').first.strip
	
	if /[a-zA-Z]/.match?(string)		
		if !BOOLEAN_HASH[string].nil?		
			return BOOLEAN_HASH[string]
		end
		return string
	elsif eval(string).is_a? Numeric		
		return eval(string)
	end
end

def parse_hash(file_lines)
	the_hash = Hash.new
	file_lines.each do | line |
		if line.split('=').length > 1
			key, value = line.split('=', 2).each do | str | str.strip! end
			the_hash.store(key, get_type(value))
		end
	end

	return the_hash
end

puts parse_hash(file_lines)