class ApplicationJob < ActiveJob::Base
  include Backburner::Queue

  # Parser errors can't be retried
  # however they shouldn' really happen, and if parser doesn't support
  # annontated games then I might miss that fact...
  # but the retry job noise will drown out the good games..
  # discard_on Bchess::PGN::ParserException
  # not much can be done on a missing file
  discard_on Errno::ENOENT
end
