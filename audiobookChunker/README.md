Audiobook Chunker is a small program to solve a small problem. It uses PyDub (https://github.com/jiaaro/pydub).

I purchased a cheap wireless headset which reads audio files, in order, from a micro-SD card. After being turned off and back on, it returns to the start of the last track it was playing. It does not support skipping ahead in a track. The behavior was fine for music, but annoying when fourteen minutes into a seventeen minute audiobook track.

This program breaks each mp3 file within the target folder into chunks, orders and names them for correct playback (assuming they were originally named in an ordered fashion), and saves these chunks back into the folder. It deletes the original files.
