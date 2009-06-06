#!/usr/bin/ruby -Ku

require 'cgi'

cgi = CGI.new

open("/tmp/webhook-log.txt", "a") {|f|
  f.puts
  f.puts "username: #{cgi['username']}"
  f.puts "url: #{cgi['url']}"
  f.puts "count: #{cgi['count']}"
  f.puts "status: #{cgi['status']}"
  f.puts "comment: #{cgi['comment']}"
  f.puts "timestamp: #{cgi['timestamp']}"
  f.puts "is_private: #{cgi['is_private']}"
  f.puts "key: #{cgi['key']}"
}

cgi.out("text/plain") { "ok\n" }
