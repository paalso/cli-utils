#!/usr/bin/env python3

import sys
import webbrowser


def main():
    args = sys.argv[1:]
    if not args:
        print("Usage: goo.py 'your query'")
        sys.exit(1)
    query = f"https://www.google.com/search?q={' '.join(args)}"
    webbrowser.open(query)


if __name__ == '__main__':
    main()
