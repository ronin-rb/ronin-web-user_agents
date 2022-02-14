#
# ronin-web-user_agents - Yet another User-Agent randomiser library.
#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-web-user_agents.
#
# ronin-web-user_agents is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-web-user_agents is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-web-user_agents.  If not, see <https://www.gnu.org/licenses/>
#

# browsers
require 'ronin/web/user_agents/chrome'
require 'ronin/web/user_agents/firefox'

# crawlers
require 'ronin/web/user_agents/google_bot'

module Ronin
  module Web
    #
    # Provides categories of common `User-Agent` strings.
    #
    # ## Example
    #
    # Get a random `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.random
    #     # => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.230 Safari/537.36"
    #
    # Get a random Chrome `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.chrome.random
    #     # => "Mozilla/5.0 (Linux; Android 5.1.1; Redmi Note 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4688.3 Mobile Safari/537.36"
    #
    # Get a random Firefox `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.firefox.random
    #     # => "Mozilla/5.0 (Windows NT 6.1; rv:78.0.2) Gecko/20100101 Firefox/78.0.2"
    #
    # Get a random `GoogleBot` `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.google_bot.random
    #     # => "GoogleBot/2.1 (+http://www.google.com/bot.html)"
    #
    module UserAgents

      #
      # Google Chrome `User-Agent` strings.
      #
      # @return [Chrome]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.chrome.random
      #   # => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.2495.20 Safari/537.36"
      #
      # @api public
      #
      def self.chrome
        Chrome
      end

      #
      # Alias for {chrome}.
      #
      # @return [Chrome]
      #
      # @see chrome
      #
      # @api public
      #
      def self.google_chrome
        Chrome
      end

      #
      # Firefox `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.firefox.random
      #   # => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16.0; rv:52.55.07) Gecko/20100101 Firefox/52.55.07" 
      #
      # @api public
      #
      def self.firefox
        Firefox
      end

      #
      # `GoogleBot` `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.google_bot.random
      #   # => "GoogleBot/2.1 (+http://www.google.com/bot.html)"
      #
      # @api public
      #
      def self.google_bot
        GoogleBot
      end

      #
      # Returns a random Browser `User-Agent` string from one of the following:
      #
      # * {chrome}
      # * {firefox}
      #
      # @return [String, nil]
      #   A random `User-Agent` string from the category.
      #   Note, `nil` can be returned if the given block filter out all User
      #   Agents.
      #
      # @example
      #   Ronin::Web::UserAgents.random
      #   # => "Mozilla/5.0 (X11; Fedora; Linux i686; en-IE; rv:123.4) Gecko/20100101 Firefox/123.4"
      #
      def self.random(&block)
        method = [
          :chrome,
          :firefox,
        ].sample

        return send(method).random(&block)
      end
    end
  end
end
