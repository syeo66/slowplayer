# SlowPlayer
A slow movie player on the Waveshare e-paper screen for Rasperry Pi.
Inspired by [How to Build a Very Slow Movie Player for £120 in 2020](https://debugger.medium.com/how-to-build-a-very-slow-movie-player-in-2020-c5745052e4e4) by [@TomWhitwell](https://github.com/TomWhitwell/)

## Requirements

You'd have to install ffmpeg and imagemagick to make it work.

```bash
sudo apt-get update
sudo apt-get install imagemagick ffmpeg
```

To compile the IT8951 code you'd have also to install the bcm2835 library.

```bash
wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.68.tar.gz                       
tar xvfz bcm2835-1.68.tar.gz
cd bcm2835-1.68
./configure
make
sudo make install
```

After that you can compile IT8951

```bash
cd slowplayer/IT8951/
make
```

## Install cron job

```bash
crontab < crontab
```
