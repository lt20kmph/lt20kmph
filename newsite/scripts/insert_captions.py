#!/usr/bin/python

import sqlite3

DATABASE = "lt20kmph.db"

SQL_INSERT = (
    "INSERT INTO picture (pic_no, story_no, caption) VALUES (?, ?, ?)"
)

# Change the following variables captions file and story number
CAPTIONS_FILE = "30_captions.txt"

STORY_NO = 30


# Usage: python insert_captions.py
def main():
    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()
    with open(CAPTIONS_FILE, "r") as f:
        for pic_no, line in enumerate(f):
            line = line.strip()
            print("Inserting picture %d: %s" % (pic_no + 1, line))
            c.execute(SQL_INSERT, (pic_no + 1, STORY_NO, line))
    conn.commit()
    conn.close()


if __name__ == "__main__":
    main()
