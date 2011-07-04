#!/usr/bin/env ruby
# 
#  amq_inspect.rb
#  Subscribes to a given activemq queue and prints all messages received on it
#  
#  Created by Caius Durling on 2011-07-01.
# 

STDOUT.sync = true; STDOUT.flush
STDERR.sync = true; STDERR.flush

require "rubygems"
require "stomp"
require "logger"

logger = Logger.new(STDOUT)

client_settings = {:login => "", :passcode => "", :host => "127.0.0.1", :port => 61613}

client = Stomp::Client.new(client_settings[:login], client_settings[:passcode], client_settings[:host], client_settings[:port])

# Load from QUEUE|QUEUES, TOPIC|TOPICS and turn them into the right activemq full queue name
queues = []
%w(QUEUE TOPIC).each do |type|
  queues.push *((ENV[type] || ENV["#{type}s"] || "").split(",").map {|s| "/#{type.downcase}/#{s}" })
end

queues.each do |queue|
  logger.info "Subscribing to #{queue}"
  client.subscribe(queue) do |msg|
    logger.debug "Message received on #{queue.inspect}: headers: #{msg.headers.inspect} :: body: #{msg.body.inspect}"
  end
end

begin
  client.join
rescue Interrupt
  logger.info "\n<<Interrupt received>>\n"
  exit(1)
ensure
  logger.info "Ending listening to #{queues.inspect}"
end
