gpio-utilities
==============

Raspberry Pi GPIO utilities

Buttons, rotary encoders etc.


## Installation

You need to install the wiringpi library first: http://wiringpi.com


 git clone git://git.drogon.net/wiringPi
 git pull origin
 cd wiringPi
 ./build


### Wiringpi Ruby

For the rotary encoder you need a special version of the wiringPi ruby library, so you 
may as well install it anyway.


 git clone https://github.com/libbymiller/WiringPi2-Ruby.git
 gem build wiringpi.gemspec
 sudo gem install wiringpi2






