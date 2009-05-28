#!/usr/bin/ruby

require 'yaml'
require 'fileutils'

CONFIG_FILE = 'rsspost_config.yml'

config = YAML.load_file(CONFIG_FILE)
puts "rm #{config['posted_db']}"
FileUtils.rm_f config['posted_db']
