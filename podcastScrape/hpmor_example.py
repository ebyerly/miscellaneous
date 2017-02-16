from podcastScrape import podcastScrape
import os

if __name__ == '__main__':
    podcastScrape(os.path.join(os.path.expanduser('~'), 'HPMoR'),
              'http://www.hpmorpodcast.com/?page_id=56'
              'HPMoR_Chap_')
