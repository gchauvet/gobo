class AA

create

	make

feature

	make
		do
			f
		end

	f
		require
			tag1: g;;
			tag2: g
		do
			print ("Failed")
		end

	g: BOOLEAN
		do
			Result := True
		end

end