import os
import glob
from math import ceil
from pydub import AudioSegment

def audiobookChunker(folderpath, audiobook_title = 'chunked', seconds = 15,
                     delete_old = True):
    """
    Takes four parameters:
    folderpath where all to-be-chunked audio files are located
    audiobook_title for attractive naming (defaults to 'chunked')
    seconds as length to make each chunk (defaults to 15)
    delete_old is whether original audio files are deleted (defaults as True)
    """
    # Creates a list of the original audio files to be chunked.
    original_mp3s = sorted(glob.glob(folderpath + os.path.sep + '*.mp3'))
    # Defines digit length of all mp3s for export/naming.
    digits_omp3s = len(str(len(original_mp3s)))

    for i, audio_file in enumerate(original_mp3s):
        # "Base" title on which each chunk is written to folder
        title_base = '{0}_{1}_'.format(audiobook_title,
                                       str(i + 1).rjust(digits_omp3s, '0'))
        # Converts mp3 into an AudioSegment object.
        audio_segment = AudioSegment.from_mp3(audio_file)
        frames = audio_segment.frame_count()
        # Defines the number of chunks and the frames in each chunk.
        chunks = ceil(len(audio_segment) / (seconds * 1000))
        chunk_frames = ceil(frames / chunks)
        # Defines digit length for the worked mp3 for export/naming.
        digits_chunks = len(str(chunks))
        # For each chunk, slices and exports it with proper naming.
        for chunk in range(0, chunks):
            start = chunk * chunk_frames
            if chunk == chunks - 1:
                finish = int(frames)
            else:
                finish = (chunk + 1) * chunk_frames - 1
			slice = audio_segment.get_sample_slice(start, finish)
            title = '{2}.mp3'.format(str(chunk + 1).rjust(digits_chunks, '0'))
            file = os.path.join(folderpath, title_base + title)
            slice.export(file, format='mp3')
				
	# Deletes original files
    if delete_old:
        for mp3 in original_mp3s:
            os.remove(mp3)

# If launched as a standalone, assumes all mp3s in the folder and subfolders are
# to be converted.
if __name__ == '__main__':
    mp3list = glob.glob('*.mp3')
    if len(mp3list) > 0:
        try:
            os.mkdir('MP3s')
        except FileExistsError:
            pass
        for mp3 in mp3list:
            os.rename(mp3, os.path.join('MP3s', mp3))
    dirs = [name for name in os.listdir() if os.path.isdir(name)]
    print('Files to be converted:\n{0}'.format('\n'.join(dirs))
    for dir in dirs:
        print('Now converting: {0}'.format(dir))
        audiobookChunker(dir, audiobook_title = dir)
