# CONVERT VIDEO FILES TO .mov FOR DAVINCI RESOLVE

The free version of Davinci Resolve do not allow to use video files with H264 codec. Many tips on the internet suggest to convert these files to another codec, but the codecs that they suggest creates huge files. A H264 file that has a size of 1GB can easily turn to a 30GB file with the codecs they suggest.

After many tests, I found a codec that creates smaller files (still bigger than the H264, but way lesser than the most of suggestions) that works on Davinci Resolve.
The codec is the **libxvid**.

Example:
```bash
ffmpeg -i "INPUT_FILE.mp4" -c:v libxvid -q:v 5 -acodec pcm_s16le -f mov "OUTPUT_FILE.mov"
```

**NOTE**: change the `-q:v` parameter to change the quality of the output file. The values can be between 1 (best quality) to 31 (worst quality).
