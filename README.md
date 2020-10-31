# slowplayer
a slow movie player for rasperry pi

## Requirements

You'd have to install ffmpeg and imagemagick to make it work.

```bash
sudo apt-get update
sudo apt-get install imagemagick ffmpeg
```

To compile the IT8951 code you'd have also to install the bcm2835 library.

```bash
wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.68.tar.gz                       
tar xvfz bcm2835-1.68.tar.gz;
cd bcm2835-1.58;
./configure;
make;
sudo make install
```

After that you can compile IT8951

```bash
cd IT8951/
make
```
