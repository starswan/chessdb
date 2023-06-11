#!/bin/bash
#
# $Id$
#
export HOME=`echo ~`
source $HOME/.bash_profile
dirname=`dirname $0`
cd $dirname
program=$1
pidfile="tmp/pids/$program.pid"
logfile="log/$program.log"
pwd
bundle exec rake backburner:work 2>&1 >>$logfile &
echo $! >$pidfile
