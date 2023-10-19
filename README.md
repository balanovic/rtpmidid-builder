# rtpmidid-builder
Deb Package builder for rtpmidid. Specifically for debian bookworm on orangepi zero2


## Overview

This project is made we can build a arm64 package of rtpmdid for debian bookworm. 


## Usage

Running the following will use docker to build the apt packages it will then copy them out of the image to a directory called output.


Run the following command:

`make`


## Notes

- This project is purely there until the rtpmidid project releases new debian packages. 
