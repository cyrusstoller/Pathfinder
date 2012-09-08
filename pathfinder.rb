require 'optparse'

def main(options = {})
  p options
end

if __FILE__ == $PROGRAM_NAME
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: pathfinder.rb [options]"

    opts.on( '-h', '--help', 'Help' ) do
      puts opts
      exit
    end
    
    opts.on('-l LENGTH', '--length=LENGTH', Integer, "Length of the subpaths") do |l|
      options[:length] = l
    end
  end.parse!
  
  main(options)
end