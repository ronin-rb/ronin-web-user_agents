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
    #
    # Get a random `GoogleBot` `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.google_bot.random
    #
    # Get a random Chrome `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.chrome.random
    #
    # Get a random Firefox `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.firefox.random
    #
    module UserAgents

      #
      # Google Chrome `User-Agent` strings.
      #
      # @return [Chrome]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.chrome.random
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
