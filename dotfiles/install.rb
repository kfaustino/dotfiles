#!/usr/bin/env ruby
# from http://github.com/mislav/dotfiles

home = File.expand_path('~')

Dir.chdir File.dirname(__FILE__) do
  dotfiles_dir = Dir.pwd.sub(home + '/', '')

  Dir['*'].each do |file|
    next if !File.extname(file).empty? || File.directory?(file) || file =~ /README/
    target = File.join(home, ".#{file}")
    unless File.exist? target
      `ln -vsf #{File.join(dotfiles_dir, file)} #{target}`    
    end
  end

end
