private
writeLoop: aLogger
	"Write the default instance out to a file every WritePeriod"

	[
		self save: aLogger stonFile: self writeFilename value.
		self writePeriod wait ] repeat.