#
# $Id$
#
Backburner.configure do |config|
  config.beanstalk_url = ["beanstalk://127.0.0.1"]
  config.tube_namespace = "chessdb.#{Rails.env}"
  config.namespace_separator = '.'
  config.primary_queue = 'default'
  config.logger = Rails.logger
  # retrying a job is unlikely to work unless its a deadlock issue
  config.max_job_retries = 15
  # some big file parsing takes longer than 2 minutes - 166 seconds measured for 1.4Gb
  config.respond_timeout = 300
  # This ought to be the correct error handling strategy, except that sometimes BeanStalk reports connection closed
  # and I'm not quite sure how to reset the connection for that case
  config.on_error = lambda { |ex| Rails.logger.error(ex); ActiveRecord::Base.connection.reconnect! }
  # config.on_error = lambda { |ex| Rails.logger.error(ex); exit(1) }
end

module ActiveJob
  module QueueAdapters
    # == Backburner adapter for Active Job
    #
    # Backburner is a beanstalkd-powered job queue that can handle a very
    # high volume of jobs. You create background jobs and place them on
    # multiple work queues to be processed later. Read more about
    # Backburner {here}[https://github.com/nesquena/backburner].
    #
    # To use Backburner set the queue_adapter config to +:backburner+.
    #
    #   Rails.application.config.active_job.queue_adapter = :backburner
    #
    # using pri: here fixes a bug (in rails 4.2.10 and still present)
    # fixes a bug whereby the BackBurner queue adapter doesn't respect the priority
    # set either by label/string or integer on the job class. The adapter thinks that the 'JobWrapper'
    # class is the actual class for the job which needs to have a queue_priority method that returns
    # either a symbol/string or an actual priority.
    class BackburnerAdapter
      def enqueue(job) #:nodoc:
        # Backburner::Worker.enqueue job.class, [ job.serialize ], queue: job.queue_name
        Backburner::Worker.enqueue JobWrapper, [ job.serialize ], queue: job.queue_name, pri: job.class.queue_priority
      end

      def enqueue_at(job, timestamp) #:nodoc:
        delay = timestamp - Time.current.to_f
        # Backburner::Worker.enqueue job.class, [ job.serialize ], queue: job.queue_name, delay: delay
        Backburner::Worker.enqueue JobWrapper, [ job.serialize ], queue: job.queue_name, delay: delay, pri: job.class.queue_priority
      end
    end

    class JobWrapper #:nodoc:
      class << self
        def perform(job_data)
          Base.execute job_data
        end
      end
    end
  end
end
