require 'optparse'
require 'yaml'

def main(options = {}, filenames = [])
  options = finalize_options(options)
  output_file = File.open(options[:output_file], "w")
  filenames.each do |filename|
    find_subpaths(filename, output_file , options[:length])
  end
  output_file.close
end

def find_subpaths(filename, output_file, length)

end

def finalize_options(options)
  default_options = YAML.load_file('defaults.yml')
  res = { 
          :length => default_options["path_length"], 
          :output_file => default_options["output_file"]
        }
  res.merge(options)
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