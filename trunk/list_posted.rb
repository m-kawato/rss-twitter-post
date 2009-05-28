#!/usr/bin/env ruby -Ku

require 'gdbm'
GDBM.open('twitter_posted.gdbm') {|db|
  db.each_pair {|key, value|
    puts "key:#{key}, value:#{value}"
  }
}
