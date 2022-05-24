local modules = peripheral.find("neuralInterface")
if not modules then
	error("Must have a neural interface", 0)
end