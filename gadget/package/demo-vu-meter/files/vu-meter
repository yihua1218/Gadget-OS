#!/usr/bin/env python
import CHIP_IO.GPIO as gpio
import alsaaudio
import audioop
import math

inp = alsaaudio.PCM(alsaaudio.PCM_CAPTURE, alsaaudio.PCM_NORMAL, 'default')
inp.setchannels(2)
inp.setrate(44100)
inp.setformat(alsaaudio.PCM_FORMAT_S16_LE)
inp.setperiodsize(1024)

lo = math.log(2000)
hi = math.log(20000)
pinmap = [3,2,1,0, 4,5,6,7]
val_max = len(pinmap)/2
val_min = 0
pinid = "CSID{0}"
retry=10

for x in pinmap:
	gpio.setup(pinid.format(x), gpio.OUT)

while True:
	l,data = inp.read()
	if l:
		try:
			pins = []
			lchannel=audioop.tomono(data, 2, 1, 0)
			rchannel=audioop.tomono(data, 2, 0, 1)
			# transform data to logarithmic scale
			lvu = (math.log(float(max(audioop.max(lchannel, 2),1)))-lo)/(hi-lo)
			rvu = (math.log(float(max(audioop.max(rchannel, 2),1)))-lo)/(hi-lo)
			lval = min(max(int(lvu*val_max),val_min),val_max)
			rval = min(max(int(rvu*val_max),val_min),val_max)
			pins.extend( pinmap[0:lval] )
			pins.extend( pinmap[val_max:val_max+rval] )

			for x in pinmap:
				if x in pins:
					gpio.output(pinid.format(x), gpio.HIGH)
				else:
					gpio.output(pinid.format(x), gpio.LOW)
		except:
			if retry<=0:
				print("Program Closed")
				break
			else:
				retry -= 1

gpio.cleanup()
