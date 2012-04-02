Windows command line script to bulk download Facebook photos you're tagged in.

For an easier-to-use alternative, try [PhotoGrabber](http://code.google.com/p/photograbber/), which has a GUI and uses [OAuth](http://en.wikipedia.org/wiki/Oauth).

### Why? ###
I wanted to keep Facebook photos I'm tagged in with the rest of my photo library so it's all in one place, but didn't want to individually save hundreds of photos. I tried [PhotoGrabber](http://code.google.com/p/photograbber/) but only got 80 of the 280 photos I was tagged in. So I wrote a simple Ruby script that uses [selenium](http://seleniumhq.org/) to  fire up Firefox, login to my profile page, and download everything under the 'Photos of You' header.

###Usage###
You'll need Firefox installed. Then download the .exe file, and in the command prompt run

```
./fb_photo_download.exe email password target_folder
```

Photos that already exist in the target folder won't be re-downloaded, so you can run the script again to get only new photos.