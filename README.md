# ronin-web-user_agents

[![CI](https://github.com/ronin-rb/ronin-web-user_agents/actions/workflows/ruby.yml/badge.svg)](https://github.com/ronin-rb/ronin-web-user_agents/actions/workflows/ruby.yml)
[![Code Climate](https://codeclimate.com/github/ronin-rb/ronin-web-user_agents.svg)](https://codeclimate.com/github/ronin-rb/ronin-web-user_agents)

* [Website](https://ronin-rb.dev/)
* [Source](https://github.com/ronin-rb/ronin-web-user_agents)
* [Issues](https://github.com/ronin-rb/ronin-web-user_agents/issues)
* [Documentation](https://ronin-rb.dev/docs/ronin-web-user_agents/frames)
* [Slack](https://ronin-rb.slack.com) |
  [Discord](https://discord.gg/6WAb3PsVX9) |
  [Twitter](https://twitter.com/ronin_rb)

## Description

Yet another `User-Agent` randomiser library.

## Features

* Generates realistic looking but random `User-Agent` strings from known values.
* Small footprint.
* Fast.
* Zero dependencies.

## Examples

### Random

Get a random `User-Agent` string:

```ruby
user_agent = Ronin::Web::UserAgents.random
# => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.230 Safari/537.36"
```

Get a random Chrome `User-Agent` string:

```ruby
user_agent = Ronin::Web::UserAgents.chrome.random
# => "Mozilla/5.0 (Linux; Android 5.1.1; Redmi Note 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4688.3 Mobile Safari/537.36"
```

Get a random Firefox `User-Agent` string:

```ruby
user_agent = Ronin::Web::UserAgents.firefox.random
# => "Mozilla/5.0 (Windows NT 6.1; rv:78.0.2) Gecko/20100101 Firefox/78.0.2"
```

Get a random `googlebot` `User-Agent` string:

```ruby
user_agent = Ronin::Web::UserAgents.google_bot.random
# => "Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GoogleBot/2.1; +http://www.google.com/bot.html) Chrome/94.0.4602.7 Safari/537.36"
```

Spoof [net/http]'s `User-Agent` string:

```ruby
require 'net/https'

uri      = URI("https://www.whatismybrowser.com/detect/what-is-my-user-agent")
headers  = {'User-Agent' => Ronin::Web::UserAgents.chrome.random}
response = Net::HTTP.get(uri,headers)
```

### Spoofing

Spoof [open-uri]'s `User-Agent` string:

```ruby
require 'open-uri'

url       = "https://www.whatismybrowser.com/detect/what-is-my-user-agent"
headers   = {'User-Agent' => Ronin::Web::UserAgents.chrome.random}
temp_file = URI.open(url,headers)
```

Spoof [mechanize]'s `User-Agent` string:

```ruby
require 'mechanize'

agent = Mechanize.new
agent.user_agent = Ronin::Web::UserAgents.chrome.random
page = agent.get("https://www.whatismybrowser.com/detect/what-is-my-user-agent")
```

Spoof [rest-client]'s `User-Agent` string:

```ruby
require 'rest-client'

RestClient.get "https://www.whatismybrowser.com/detect/what-is-my-user-agent",
               user_agent: Ronin::Web::UserAgents.chrome.random
```

Spoof `curl`'s `User-Agent` string:

```shell
user_agent="$(ruby -Ilib -r ronin/web/user_agents -e 'print Ronin::Web::UserAgents.chrome.random')"

curl --user-agent "$user_agent" https://www.whatismybrowser.com/detect/what-is-my-user-agent
```

[net/http]: https://rubydoc.info/stdlib/net
[open-uri]: https://rubydoc.info/stdlib/open-uri
[mechanize]: https://github.com/sparklemotion/mechanize#readme
[rest-client]: https://github.com/rest-client/rest-client#readme

## Requirements

* [Ruby] >= 2.7.0

## Install

```shell
$ gem install ronin-web-user_agents
```

### Gemfile

```ruby
gem 'ronin-web-user_agents', '~> 0.1'
```

### gemspec

```ruby
gem.add_dependency 'ronin-web-user_agents', '~> 0.1'
```

## Development

1. [Fork It!](https://github.com/ronin-rb/ronin-web-user_agents/fork)
2. Clone It!
3. `cd ronin-web-user_agents/`
4. `bundle install`
5. `git checkout -b my_feature`
6. Code It!
7. `bundle exec rake spec`
8. `git push origin my_feature`

## License

Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3@gmail.com)

This file is part of ronin-web-user_agents.

ronin-web-user_agents is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ronin-web-user_agents is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with ronin-web-user_agents.  If not, see <https://www.gnu.org/licenses/>.

[Ruby]: https://www.ruby-lang.org
