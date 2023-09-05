#!/bin/bash

### Howdy Bitches
# You'll probably need to install jq; for Linux it's `sudo apt install jq`, idk for Windows and Mac
# You'll also need to get an API key (it's free) from here: http://ocr.space/OCRAPI
# Pending your OS, you'll need to change the screenshot tool (`gnome-screenshot` here), all that matters is that the screenshot 
# 1. happens, and 2. is saved to a file (for the `curl` function to know what it's sending).
# Enjoy.



# takes the screenshot
gnome-screenshot -a -f "ocr.png"

# sends to API
text_res=$(curl -H "apikey:***REMOVED***" --form "file=@ocr.png" --form "language=eng" --form "isOverlayRequired=true" https://api.ocr.space/Parse/Image)

# parses json response and puts in paste buffer
echo ${text_res} | jq -r '.ParsedResults[0].TextOverlay.Lines[].Words[].WordText' | tr '\n' ' ' | xclip -selection clipboard
