#!/bin/bash -x
#
# $Id$
#
localfile=log/chessdb_development.sql
remote=ford
remote_dir=starswan.git/projects/chessdb
remotefile=$remote:starswan.git/projects/chessdb/log/chessdb.sql
date
nice rsync -e ssh -avPpz $localfile $remotefile
if [ $? == 0 ]
then
  ssh $remote "cd $remote_dir && . ~/.bash_profile && DISABLE_DATABASE_ENVIRONMENT_CHECK=1 nice rake db:drop"
  ssh $remote "cd $remote_dir && . ~/.bash_profile && nice rake db:create"
  date
  time ssh ford "cd $remote_dir && . ~/.bash_profile && nice rails db -p <log/chessdb.sql"
  rm -f log/chessdb.sql
fi
