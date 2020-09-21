# frozen_string_literal: true

# installer for dotfiles
# author: Playstay

require 'optparse'
require 'pathname'
require 'fileutils'

LN_OPTION = { verbose: true }.freeze

def link_files(source, destination, fileutil, ignore_files)
  source.each_child do |dir|
    next if ignore_files.include?(dir.basename.to_s)
    next if dir.basename.to_s.end_with?('~')

    if dir.directory?
      link_files(dir, destination, fileutil, ignore_files)
      next
    end

    copy_file(destination, dir, fileutil)
  end
end

def copy_file(destination, dir, fileutil)
  # FIXME: Pathnameインスタンスが親ディレクトリのため仮想のディレクトリを指定しないといけない
  target_dir = dir.expand_path(destination + './hoge')
  unless target_dir.exist?
    fileutil.makedirs(target_dir.parent.to_s, **LN_OPTION)
  end
  fileutil.ln_s(dir.expand_path.to_s, target_dir.to_s, **LN_OPTION)
end

def ignore_list(additional = nil)
  ignore_files = Pathname.new('./.default_ignore').readlines(chomp: true)
  ignore_files.append(additional) unless additional.nil?
  ignore_files
end

opt = OptionParser.new

dest_dir = Pathname(ENV['HOME'])

fileutil = FileUtils

opt.on('-d DIRECTORY', '--directory DIRECTORY', 'install specificied directory') do |dir|
  dest_dir = Pathname(dir)
end
opt.on('-D', '--debug') do |_v|
  fileutil = FileUtils::DryRun
end

opt.parse(ARGV)

# 絶対パスでは実装が難しいので相対パスで実装
source_dir = Pathname('../')

link_files(source_dir, dest_dir, fileutil, ignore_list)
