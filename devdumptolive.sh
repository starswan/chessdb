#!/bin/bash -x
#
# $Id$
#
localfile=log/chessdb_development.sql
remotefile=alice:html/chessdb/shared/log/chessdb.sql
#localfile=db/data.yml
#remotefile=alice:html/bfrails4/shared/log/data.yml
#if [ -f $localfile.gz ]
#then
#  nice gunzip -f $localfile.gz 
#fi
date
nice rsync -e ssh -avPpz $localfile $remotefile
#nice -20 gzip -9 -f $localfile &
if [ $? == 0 ]
then
  ssh alice 'cd html/chessdb/current && . ~/.bash_profile && DISABLE_DATABASE_ENVIRONMENT_CHECK=1 nice rake db:drop'
  ssh alice 'cd html/chessdb/current && . ~/.bash_profile && nice rake db:create'
  date
  time ssh alice "cd html/chessdb/current && . ~/.bash_profile && nice rails db -p <log/chessdb.sql"
fi
#time nice rake db:data:load
#time nice rake db:migrate
