#!/usr/bin/env ruby -Ku

require 'rubygems'
require 'yaml'
require 'gdbm'
require 'jcode'
require 'rss'
require 'twitter'

BODY_LENGTH = 115
CONFIG_FILE = 'rsspost_config.yml'

class String
  def truncate(length)
    return self if self.jlength <= length
    i = 0
    new_string = ''
    self.each_char {|char|
      break if i >= length
      new_string << char
      i += 1
    }
    return new_string
  end
end

config = YAML.load_file(CONFIG_FILE)

GDBM.open(config['posted_db']) {|db|
  client = nil
  config['feeds'].each {|feed_item|
    rssfile = feed_item['rss']
    puts "rssfile: <#{rssfile}>"
    rss = RSS::Parser.parse(IO.read(rssfile))
    rss.items.reverse.each {|item|
#p item.link
      next if db.has_key?(item.link)
p item.link
      db[item.link] = '1'
      tag_string = ''
      if feed_item['subjects']
        tag_string = item.dc_subjects.map{|subject| "[#{subject.content}]"}.join
      end
      description = (item.description == '' ? '' : ": #{item.description}")
      message = "[#{feed_item['name']}]#{tag_string} #{item.title}#{description}" 
      message = message.truncate(BODY_LENGTH) + " #{item.link}"
      puts message
      if client == nil
        client = Twitter::Client.new(:login => config['user'],
                   :password => config['password'])
      end
      client.status(:post, message)
    }
  }
}

