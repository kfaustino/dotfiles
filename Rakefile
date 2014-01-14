# from http://github.com/ryanb/dotfiles/
require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false

  Dir['**/*'].each do |file|
    next unless file =~ /\.symlink/
    file_name = dot_file_name(file)

    if File.exist?(File.join(ENV['HOME'], file_name))
      if File.identical? file, File.join(ENV['HOME'], file_name)
        puts "identical ~/#{file_name}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/#{file_name}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/#{file_name}"
        end
      end
    else
      link_file(file)
    end
  end
end

def dot_file_name(file)
  file_name = File.basename(file.sub(/\.symlink\.erb|\.symlink/, ''))
  ".#{file_name}"
end

def replace_file(file)
  file_name = dot_file_name(file)
  system %Q{rm -rf "$HOME/#{file_name}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    generate_dot_file(file)
  else
    link_standard_file(file)
  end
end

def generate_dot_file(file)
  file_name = dot_file_name(file)
  puts "generating ~/#{file_name}"
  File.open(File.join(ENV['HOME'], "#{file_name}"), 'w') do |new_file|
    new_file.write ERB.new(File.read(file)).result(binding)
  end
end

def link_standard_file(file)
  file_name = dot_file_name(file)
  puts "linking ~/#{file_name}"
  system %Q{ln -vsf "$PWD/#{file}" "$HOME/#{file_name}"}
end
