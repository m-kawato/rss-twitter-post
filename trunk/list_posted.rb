#!/usr/bin/ruby -Ku

require 'gdbm'
require 'yaml'

CONFIG_FILE = 'rsspost_config.yml'

config = YAML::load_file(CONFIG_FILE)

GDBM.open(config['posted_db']) {|db|
  db.each_pair {|key, value|
    puts "key:#{key}, value:#{value}"
  }
}
