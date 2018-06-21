def arr_mult(arr1)
	int_hash = Hash.new 0
	arr1.each do | int |
		factors = []		
		
		arr1.each do | sub_int |		
			if int % sub_int == 0 && sub_int != int
				factors << sub_int
			end
		end

		int_hash[int] = factors		
	end
	
	return int_hash
end

puts arr_mult([10, 5, 2, 20])