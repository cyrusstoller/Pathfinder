# Pathfinder

This produces a csv file that is a histogram of the frequency of paths occurring of a certain length.

You provide a csv file describing your graph. The first column is the participant, and all subsequent columns are the order in which the user interacted with each resource. The value in those columns is the resource that was accessed.

The output file has two columns. The first is a description of the path and the second is the frequency.

```
Usage: pathfinder.rb [options] INFILE1 [INFILE2 ...]
    -h, --help                       Help
    -l, --length=LENGTH              Length of the subpaths
    -o, --output=FILE                Name of output file
```

For example

```
$ ruby pathfinder.rb -l 3 data.csv
```

Command line options are assuming you're running Ruby 1.9.3