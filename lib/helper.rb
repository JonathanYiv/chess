def valid_position?(x,y)
	return false if !(0..7).include?(x) || !(0..7).include?(y)
	true
end