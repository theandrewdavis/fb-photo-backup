Windows command line script to bulk download Facebook photos you're tagged in.

### Why? ###
I wanted a local backup of all the Facebook photos I'm tagged in. That way all my photos are in one place and I won't lose them if a friend deletes their Facebook account or changes their privacy settings. I didn't want to individually save hundreds of photos, though. I tried [PhotoGrabber](http://code.google.com/p/photograbber/) but it could only get about half the photos I was tagged in. It turns out that depending on your friends' privacy settings, the Facebook API can only access some of the photos you can see from the website. Since the API wouldn't work for me, I had to resort to web scraping. So I wrote a simple Ruby script that uses [selenium](http://seleniumhq.org/) to  fire up Firefox, login to my profile page, and download everything under the 'Photos of You' header.

###Usage###
You'll need Firefox installed. Then download the .exe file, and in the command prompt run

```
./fb_photo_download.exe email password target_folder
```

Photos that already exist in the target folder won't be re-downloaded, so you can run the script again to get only new photos.