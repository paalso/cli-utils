#!/usr/bin/env python3

import random, sys

BOOK_LIST_PATH = '/home/paalso/Books/books_selling/non-sold-books.txt'
DEFAULT_BOOKS_TO_CHOOSE_NUMBER = 5


def get_random_items(items_path, number_of_items_to_get):
    with open(items_path) as f:
        items = f.readlines()

    return [random.choice(items).strip()
            for _ in range(number_of_items_to_get)]


def main():
    args = sys.argv
    number_of_items_to_get = int(args[1]) if len(args) > 1 \
                                          else DEFAULT_BOOKS_TO_CHOOSE_NUMBER
    random_books = get_random_items(BOOK_LIST_PATH, number_of_items_to_get)
    print(*random_books, sep='\n')


if __name__ == '__main__':
    main()
