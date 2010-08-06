Bench Press
===========

Bench Press is a simple dsl around Ruby's Benchmark library.

Place the code you wish to benchmark inside of a measure block, run the
bench_press command and you'll get a markdown report containing your system
information and the realtime benchmark.

Additionally, benchmarks can be published to the
[Ruby Benchmark](http://rubybenchmark.com) via
`bench_press --publish benchmark.rb` command.

## Example

    # foo.rb
    require 'bench_press'
    extend BenchPress

    base_string = ""
    measure "string append" do
      base_string << "Hello World"
    end

    base_string = ""
    measure "string +=" do
      base_string += "Hello World"
    end

    $ bench_press foo.rb

    Foo
    ===
    Date: August 05, 2010

    System Information
    ------------------
        Operating System:    Mac OS X 10.6.4 (10F569)
        CPU:                 Intel Core 2 Duo 2.4 GHz
        Processor Count:     2
        Memory:              4 GB
        ruby 1.8.7 (2009-12-24 patchlevel 248) [i686-darwin10.2.0], MBARI 0x6770, Ruby Enterprise Edition 2010.01

    "string append" is up to 71% faster over 1000 repetitions
    ---------------------------------------------------------

        string append    0.00270986557006836 secs    Fastest
        string +=        0.00948691368103027 secs    71% Slower

## Details
The default number of repetitions is 1000 meaning each measure block is run
1000 times.

Each measure block is run in a forked subprocess in an attempt to isolate the
memory usage per measurement. As of 0.3.0, the benchmark is run twice, the
first run gets thrown away while the second run is added to the report.

## Running the binary/examples locally
I use rubygems but this library is $LOAD_PATH friendly which means we need to
set up our own load path when playing locally.

Try sourcing the .dev file

    $ source .dev

## Note on Patches/Pull Requests
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2009 Sandro Turriate. See LICENSE for details.
