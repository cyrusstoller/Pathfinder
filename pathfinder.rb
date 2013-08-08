require 'optparse'
require 'yaml'
require 'csv'

def main(options = {}, filenames = [])
  options = finalize_options(options)
  output_file = File.open(options[:output_file], "w")
  filenames.each do |filename|
    puts "Analyzing '#{filename}'"
    find_subpaths(filename, output_file , options[:length], options)
  end
  output_file.close
  puts "All jobs complete."
end

def find_subpaths(filename, output_file, length, options = {})
  verbose = options[:verbose] || false
  header_rows = options[:header_rows] || 0
  reverse = options[:reverse] || false
  
  output_file << filename + "\n"
  buckets = {}
  row_num = 0

  CSV.parse(File.read(filename)).each do |row|
    row_num += 1
    next if row_num < header_rows + 1
    path = return_paths(row)
    total_path_length = path.size
    if total_path_length >= length
      i = 0
      participant_num = row[0]
      while total_path_length - length + 1 > i
        sub_path = path[i...i+length]
        sub_path_key = sub_path.join("-->")
        buckets = add_to_bucket(buckets, i, row_num, sub_path_key, participant_num, reverse)
        i += 1
      end
    end
  end
  turn_buckets_to_csv(buckets, output_file, verbose)
end

def add_to_bucket(buckets, i, row_num, sub_path_key, participant_num, reverse)
  if reverse
    if buckets[participant_num].nil?
      buckets[participant_num] = [sub_path_key]
    else
      buckets[participant_num] << sub_path_key
    end
  else
    if buckets[sub_path_key].nil?
      buckets[sub_path_key] = 1
    else
      buckets[sub_path_key] += 1
    end
  end
  return buckets
end

def turn_buckets_to_csv(buckets, output_file, verbose = false)
  buckets.each do |k,v|
    row_string = [k, v].flatten.join(",")
    output_file << "#{row_string}\r\n"
    puts "#{row_string}" if verbose
  end
end

def return_paths(array)
  r = (array[1..-1]).map do |i|
    i = i.to_s
    i.strip unless i == "" or i == "\r" or i == "\n"
  end
  r.compact
end

def finalize_options(options)
  default_options = YAML.load_file('defaults.yml')
  res = { 
          :length => default_options["path_length"], 
          :output_file => default_options["output_file"],
          :verbose => default_options["verbose"],
          :header_rows => default_options["header_rows"]
        }
  res.merge(options)
end

if __FILE__ == $PROGRAM_NAME
  options = {}
  opts = OptionParser.new do |opts|
    opts.banner = "Usage: pathfinder.rb [options] INFILE1 [INFILE2 ...]"
    
    opts.on( '-h', '--help', 'Help' ) do
      puts opts
      exit!
    end
    
    opts.on('-i NUM', '--ignore-rows=NUM', Integer, "Number of header rows to ignore") do |h|
      options[:header_rows] = h
    end
    
    opts.on('-l LENGTH', '--length=LENGTH', Integer, "Length of the subpaths") do |l|
      options[:length] = l
    end
    
    opts.on('-o FILE', '--output=FILE', "Name of output file") do |o|
      options[:output_file] = o
    end
    
    opts.on('-r', '--reverse', "Reverse procedure find subpaths used by each user") do |r|
      options[:reverse] = r
    end
    
    opts.on('-v', '--[no-]verbose', "Verbose mode" ) do |v|
      options[:verbose] = v
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
  
  main(options, opts.order(ARGV))
end