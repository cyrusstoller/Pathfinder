require 'optparse'

def main(options = {}, filenames = [])
  puts options
  puts filenames
end

if __FILE__ == $PROGRAM_NAME
  options = {}
  opts = OptionParser.new do |opts|
    opts.banner = "Usage: pathfinder.rb [options] INFILE1 [INFILE2 ...]"
    
    opts.on( '-h', '--help', 'Help' ) do
      puts opts
      exit
    end
    
    opts.on('-l LENGTH', '--length=LENGTH', Integer, "Length of the subpaths") do |l|
      options[:length] = l
    end
    
    options[:output_file] = "output.txt"
    opts.on('-o FILE', '--output=FILE', "Name of output file") do |o|
      options[:output_file] = o
    end
  end
  
  begin
    opts.parse(ARGV)
  rescue Exception => e
    puts e, opts
    exit
  end
  
  if ARGV.empty?
    puts "Oops you need to add at least one file to be analyzed", opts
    exit
  end
  
  main(options, ARGV)
end