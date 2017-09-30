def within_board?(x, y)
	within_seven?(x) and within_seven?(y)
end

def within_seven?(number)
	(0..7).include?(number)
end