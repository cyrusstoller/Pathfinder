# Pathfinder

This produces a csv file that is a histogram of the frequency of paths occurring of a certain length.

You provide a csv file describing your graph. The first column is the participant, and all subsequent columns are the order in which the user interacted with each resource. The value in those columns is the resource that was accessed.

The output file has two columns. The first is a description of the path and the second is the frequency.

```
Usage: pathfinder.rb [options] INFILE1 [INFILE2 ...]
    -h, --help                       Help
    -i, --ignore-rows=NUM            Number of header rows to ignore
    -l, --length=LENGTH              Length of the subpaths
    -o, --output=FILE                Name of output file
    -r, --reverse                    Reverse procedure find subpaths used by each user
    -v, --[no-]verbose               Verbose mode
```

For example

```
$ ruby pathfinder.rb -l 3 data.csv
```

CSV parser assumes you're running Ruby 2.1.6