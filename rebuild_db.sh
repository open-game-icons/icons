#!/bin/sh
rm -f icons.db && sqlite3 icons.db < icons.sql
