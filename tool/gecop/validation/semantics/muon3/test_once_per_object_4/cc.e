class CC

inherit

	THREAD
		rename
			make as make_thread
		end

create

	make

feature
	
	make (a_b: BB)
		do
			b := a_b
			make_thread
		end

	b: BB

	execute
		do
			print ("Second call to f%N")
			b.f (True)
			print ("End of second call to f%N")
		end	
		
end
