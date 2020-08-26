# frozen_string_literal: true

# installer for dotfiles
# author: Playstay

require 'optparse'
require 'pathname'
require 'fileutils'

def link_files(source,destination,fileutil, ignore_files)
  source.each_child do |dir|
    next if ignore_files.include?(dir.basename.to_s)

    if dir.directory? then
      link_files(dir, destination,fileutil, ignore_files)
      next
    end

    # FIXME: Pathnameインスタンスが親ディレクトリのため仮想のディレクトリを指定しないといけない
    target_dir = dir.expand_path(destination + './hoge')
    fileutil.makedirs(target_dir.parent.to_s,verbose:true) unless target_dir.exist?
    fileutil.ln_s(dir.expand_path.to_s,target_dir.to_s,verbose:true)
  end
end

def ignore_list(additional = nil)
  ignore_files = Pathname.new('./.default_ignore').readlines(chomp:true)
  ignore_files.append(additional) unless additional.nil?
  ignore_files
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

# 絶対パスでは実装が難しいので相対パスで実装
source_dir = Pathname('../')

link_files(source_dir, dest_dir,fileutil, ignore_list)


