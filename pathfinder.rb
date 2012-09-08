require 'optparse'

def main(options = {})
  p options
end

if __FILE__ == $PROGRAM_NAME
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: pathfinder.rb [options]"

    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end.parse!
  
  main(options)
end