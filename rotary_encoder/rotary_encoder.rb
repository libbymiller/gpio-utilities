#!/usr/bin/env ruby
require 'wiringpi2'
require 'pp'

class Encoder

  @pin_a
  @pin_b
  @value
  @lastEncoded

  attr_accessor :pin_a, :pin_b, :value, :lastEncoded

  INPUT = 0
  PUD_UP = 2
  INT_EDGE_BOTH = 3

  def initialize(pin_a, pin_b, value, lastEncoded, io)

    @pin_a = pin_a    
    @pin_b = pin_b
    @value = value
    @lastEncoded = lastEncoded

    io.pin_mode(@pin_a,INPUT)
    io.pin_mode(@pin_b,INPUT)

    io.pullUpDnControl(@pin_a, PUD_UP)
    io.pullUpDnControl(@pin_b, PUD_UP)
    io.wiringpi_isr(@pin_a, INT_EDGE_BOTH, update(io))
    io.wiringpi_isr(@pin_b, INT_EDGE_BOTH, update(io))

  end

  def update(io)
        encoder = self

        msb = io.digital_read(encoder.pin_a)
        lsb = io.digital_read(encoder.pin_b)

        encoded = (msb << 1) | lsb;
        sum = (encoder.lastEncoded << 2) | encoded;

        if(sum == 0b1101 || sum == 0b0100 || sum == 0b0010 || sum == 0b1011) 
           encoder.value += 1
        end
        if(sum == 0b1110 || sum == 0b0111 || sum == 0b0001 || sum == 0b1000) 
           encoder.value -= 1
        end

        encoder.lastEncoded = encoded
        return nil
  end


end


puts ("Hello!");

io = WiringPi::GPIO.new

#using pins 23/24

encoder = Encoder.new(4,5,0,0,io)
value = 0

while (true)

    encoder.update(io)

    l = encoder.value
    if(l!=value)
 
      puts ("value: #{l}")
      value = l
    end
end

