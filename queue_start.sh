#!/bin/bash
#
# $Id$
#
source /home/stephen/.rvm/environments/ruby-2.7.8@chessdb
bundle install
export HOME=`echo ~`
source $HOME/.bash_profile
dirname=`dirname $0`
cd $dirname
program='queue'
pidfile="tmp/pids/$program.pid"
logfile="log/$program.log"
pwd
bundle exec rake backburner:threading:work 2>&1 >>$logfile &
echo $! >$pidfile
