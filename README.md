# SmartAndFastAssets
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'smart_and_fast_assets'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install smart_and_fast_assets
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Installation webp support on Linux

wget http://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.0.3.tar.gz

tar -xzvf libwebp-0.4.3.tar.gz

cd libwebp-1.0.3 && ./configure --prefix=$HOME/libwebp && make && make install && cd ..

apt-get install webp and libwebp-dev