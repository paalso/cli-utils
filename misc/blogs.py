#!/usr/bin/env python3

import webbrowser

LINKS = [
    'https://www.facebook.com/',
    'https://web.telegram.org/a/',
    'https://pavellss.livejournal.com/feed/'
]


def main():
    for link in LINKS:
        webbrowser.open(link)


if __name__ == '__main__':
    main()
