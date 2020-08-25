# frozen_string_literal: true

# installer for dotfiles
# author: Playstay

require 'optparse'
require 'pathname'
require 'fileutils'

BASE_DIR = Pathname.pwd.parent

def link_files(source,destination,fileutil)
  source.each_child do |dir|
    if dir.directory? do
      link_files(dir, destination,fileutil)
      continue
    end
  end
end
opt = OptionParser.new

dest_dir = Pathname(ENV['HOME'])

fileutil = FileUtils

opt.on('-d DIRECTORY','--directory DIRECTORY','install specificied directory') do |dir|
  dest_dir = Pathname(dir)
end
opt.on('-D', '--debug') do  |v|
  fileutil = FileUtils::DryRun
end

opt.parse(ARGV)

source_dir = Pathname.pwd.parent


