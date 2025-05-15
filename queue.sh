#!/bin/bash
#
# $Id$
#
export HOME=`echo ~`
source $HOME/.bash_login
dirname=`dirname $0`
cd $dirname
source $RVM_DIR/environments/ruby-3.2.8@chessdb
bundle check || bundle install
program='queue'
pidfile="tmp/pids/$program.pid"
logfile="log/$program.log"
case $1 in
   start)
      nice rake backburner:simple:work 2>&1 >>$logfile &
      echo $! >$pidfile
      ;;
   stop)
      pid=`cat $pidfile`
      kill $pid
      sleep 2
      running=`ps hp $pid | wc -l`
      if [ $running == "1" ]
      then
        kill $pid
      fi
      running=`ps hp $pid | wc -l`
      if [ $running == "1" ]
      then
        kill -9 $pid
      fi
      ;;
   *)
      echo "Usage queue.sh {start|stop}" ;;
esac
exit 0
