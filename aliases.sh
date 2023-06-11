#
# $Id$
#
alias u='time nice rake spec:models'
alias t='time nice rake spec'
alias ct='COVERAGE=true nice rake spec'
alias cov='date && COVERAGE=true nice rake spec | fgrep -v Finished | tee -a coverage.txt'
alias m='nice rake db:migrate'
alias rr='nice rake db:reset'
alias s='nice rails s -p 3004 -b localhost'
# Use threading worker and non-stop failure strategy
alias q='nice rake backburner:threading:work'
alias fq='rake backburner:work'
alias cl='clockwork config/clock.rb'
alias rc='rails c'
alias n='rspec -n'
alias f='rspec --only-failures'
