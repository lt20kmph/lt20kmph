#!/usr/bin/python

import sqlite3

DATABASE = "lt20kmph.db"

STORY_FILE = "story_30.html"


# Use this script to insert the story into the database
def insert_story():
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()

    with open(STORY_FILE, "r") as story_file:
        story = story_file.read()

    cursor.execute("UPDATE story set story=? where id=30", (story,))
    conn.commit()

    conn.close()


if __name__ == "__main__":
    insert_story()
