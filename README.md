# Sweet Javascript Macros from Ruby

This is a Ruby wrapper around the [Sweet.js macro processor](http://sweetjs.org).

Go to [sweetjs.org](http://sweetjs.org) for more information.

## Installation

    gem install sweetjs

Ensure that your environment has a JavaScript interpreter supported by
[ExecJS](https://github.com/sstephenson/execjs). Using the
[therubyracer](https://github.com/cowboyd/therubyracer) gem is a good option.

In your `Gemfile`:

    gem "sweetjs"
    gem "therubyracer"


## Usage

    require 'sweetjs'

    SweetJS.new.compile(File.read("source.sjs"))
    # => processed JavaScript source

    # Or alternatively:
    SweetJS.compile(File.read("source.sjs"))

## Acknowledgements

Thanks to [Ville Lautanala](https://github.com/lautis) who unwittingly wrote
most of the code and the README.

## Copyright

© Garry Hill, [Magnetised Ltd](https://magnetised.net/). Released under MIT license, see [LICENSE.txt](https://github.com/magnetised/sweetjs/blob/master/LICENSE.txt) for more details.

