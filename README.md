# SocialParser

![SocialParser](https://raw.githubusercontent.com/hyde2able/SocialParser/master/logo.png)

Parse social media attributes from url or construct url from attributes.

### Supported provider

`[:facebook, :github, :instagram, :github, :google, :linkedin, :medium, :pinterest, :qiita, :twitter, :vimeo, :youtube]`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'social_parser'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install social_parser
```

## Usage

The following code is an example of Twitter.

```ruby
parser = SocialParser.parse 'https://www.twitter.com/hyde141421356'
=> #<SocialParser::Provider::Twitter:0x007fc57720a690 @url="https://www.twitter.com/hyde141421356">

parser.username
=> 'hyde141421356'

parser.provider
=> :twitter

parser.url
=> 'https://www.twitter.com/hyde141421356'
```

Facebook, Google+, LinkedIn, etc... as well.

```ruby
parser = SocialParser.parse 'https://github.com/hyde2able'
=> #<SocialParser::Provider::Github:0x007fc5771e3c98 @url="https://github.com/hyde2able">

parser.username
=> 'hyde2able'

parser.provider
=> :github

parser.url
=> 'https://github.com/hyde2able'
```

An example of Youtube.

```ruby
parser = SocialParser.parse 'https://www.youtube.com/watch?v=WOvdMz4yM9U'
=> #<SocialParser::Provider::Youtube:0x007faa5e26fd58 @url="https://www.youtube.com/watch?v=WOvdMz4yM9U", @type="video">

parser.id # alias parser.username
=> 'WOvdMz4yM9U'

parser.embed_url
=> 'https://www.youtube.com/embed/WOvdMz4yM9U'
```

When an embedded URL is not provided

```ruby
parser = SocialParser.parse 'https://github.com/hyde2able'
=> #<SocialParser::Provider::Github:0x007faa5e06d7a8 @url="https://github.com/hyde2able">

parser.embed_url
# SocialParser::InvalidURIError: SocialParser::InvalidURIError
```

## Test

Excute this code

```
bundle exec rspec
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
