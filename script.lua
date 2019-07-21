--set fps
io.write("Enter framerate (anime standard = 23.976)\n")
io.flush()
fps = io.read()

--fetching shift input
io.write("\nEnter (+/-) and the number of frames you want to shift the file towards: \n")
io.flush()
tmp = io.read()

direction = string.sub(tmp,1,1)
frames = string.sub(tmp,2)

add = 0
if direction == "+" then
	io.write(string.format("\nshifting %s frames forward",frames))
	add = (1/fps)*100*frames
elseif direction == "-" then
	io.write(string.format("\nshifting %s frames backward",frames))
	add = -(1/fps)*100*frames
end

--open input file for reading and setup an output file for writing
input = assert(io.open(arg[1], "r"))
output = assert(io.open("output.ass", "w"))

--set lua time pattern
pattern = "%d:%d%d:%d%d%.%d%d"

--iterate over input, shift and write output

io.write("\n\nlines processed:\n")
progress = 0
oldprogress = 0

for line in input:lines() do
	--replace with new lengths
	line = string.gsub(line,pattern,
		function(part)
			--fetch time
			hours =  tonumber(string.sub(part,1,1))
			minutes = tonumber(string.sub(part,3,4))
			seconds = tonumber(string.sub(part,6,7))
			milliseconds = tonumber(string.sub(part,9,10))
			--add time
			milliseconds = milliseconds+add
			--correct time
			while milliseconds < 0 do
				milliseconds = milliseconds+100
				seconds = seconds-1
			end
			while milliseconds >= 100 do
				milliseconds = milliseconds-100
				seconds = seconds+1
			end
			milliseconds = string.sub(tostring(milliseconds),1,2)
			if milliseconds:sub(2,2) == "." then
				milliseconds = "0"..milliseconds:sub(1,1)
			end
			while seconds < 0 do
				seconds = seconds+60
				minutes = minutes-1
			end
			while seconds >= 60 do
				seconds = seconds-60
				minutes = minutes+1
			end
			seconds = tostring(seconds)
			if seconds:len() == 1 then seconds = "0"..seconds end
			while minutes < 0 do
				minutes = minutes+60
				hours = hours-1
			end
			while minutes >= 60 do
				minutes = minutes-60
				minutes = minutes+1
			end
			minutes = tostring(minutes)
			if minutes:len() == 1 then minutes = "0"..minutes end
			--return time
			return string.format("%d:%s:%s.%s",hours,minutes,seconds,milliseconds)
		end)
	--write output
	tmp = line .. "\n"
	output:write(tmp)
	
	--capture progress
	progress = progress+1
	if progress >= oldprogress+1000 then
		io.write(string.format("\r%d",progress))
		oldprogress = progress
	end
end


--close files
input:close()
output:close()

--Done
io.write("\n\nDone\n\n")