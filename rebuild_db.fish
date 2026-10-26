#!/usr/bin/env fish
set db (status dirname)/icons.db
set dump (status dirname)/icons.sql
rm -f $db; and sqlite3 $db <$dump
