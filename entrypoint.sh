#!/bin/sh

cd /app
mkdir _caches
mkdir _caches/templates
mkdir _caches/prices
mkdir _caches/zkb

cd db
if [ -f eve.db ]; then rm eve.db; fi
if [ -f eve.db.bz2 ]; then rm eve.db.bz2; fi

wget https://www.fuzzwork.co.uk/dump/latest/eve.db.bz2
bzip2 --decompress eve.db.bz2
cd sqlite_sql
./update_database.sh
cd ../../

python3 ./main.py --host=0.0.0.0 --port=8081