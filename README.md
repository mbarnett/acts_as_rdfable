# ActsAsRdfable
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'acts_as_rdfable'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install acts_as_rdfable
```

## Configuring ActsAsRdfable
You can configure the following default values by overriding these values using `ActsAsRdfable.configure` method.
```
dump_changes      # false by default
dump_to_path      # 'db/seeds/rdf_annotations.rb' by default
```
There's a handy generator that generates the default configuration file into config/initializers directory. Run the following generator command, then edit the generated file.
```
% rails g acts_as_rdfable:config
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
