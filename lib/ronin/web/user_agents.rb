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

require 'ronin/web/user_agents/category'

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
    # Get a random `googlebot` `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.googlebot.random
    #
    # Get a random Chrome `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.chrome.random
    #
    # Get a random Firefox `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.firefox.random
    #
    # Get a random iOS `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.ios.random
    #
    # Get a random Android `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.android.random
    #
    # Get a random Mobile `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.mobile.random
    #
    # Get a random browser `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.browser.random
    #
    # Get a random bot `User-Agent` string:
    #
    #     user_agent = Ronin::Web::UserAgents.bots.random
    #
    module UserAgents

      #
      # `googlebot` `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.googlebot.random
      #
      # @api public
      #
      def self.googlebot
        @googlebot ||= Category.load('googlebot')
      end

      #
      # All bot `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.bots.random
      #
      # @api public
      #
      def self.bots
        @bots ||= googlebot
      end

      #
      # Google Chrome `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.chrome.random
      #
      # @api public
      #
      def self.chrome
        @chrome ||= Category.load('chrome')
      end

      #
      # Alias for {#chrome}.
      #
      # @return [Category]
      #
      # @see chrome
      #
      # @api public
      #
      def self.google_chrome
        chrome
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
        @firefox ||= Category.load('firefox')
      end

      #
      # Microsoft Edge `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.edge.random
      #
      # @api public
      #
      def self.edge
        @edge ||= Category.load('safari')
      end

      #
      # Brave `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.brave.random
      #
      # @api public
      #
      def self.brave
        @brave ||= Category.load('brave')
      end

      #
      # Safari `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.safari.random
      #
      # @api public
      #
      def self.safari
        @safari ||= Category.load('safari')
      end

      #
      # Opera `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.opera.random
      #
      # @api public
      #
      def self.opera
        @opera ||= Category.load('opera')
      end

      #
      # iOS `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.ios.random
      #
      # @api public
      #
      def self.ios
        @ios ||= Category.load('ios')
      end

      #
      # Android `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.android.random
      #
      # @api public
      #
      def self.android
        @android ||= Category.load('android')
      end

      #
      # All mobile `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.mobile.random
      #
      # @api public
      #
      def self.mobile
        @mobile ||= ios + android
      end

      #
      # All browser `User-Agent` strings.
      #
      # @return [Category]
      #
      # @example
      #   user_agent = Ronin::Web::UserAgents.browsers.random
      #
      # @api public
      #
      def self.browsers
        @browsers ||= chrome + firefox + edge + brave + safari + opera + \
                      ios + android
      end

      #
      # Returns a random `User-Agent` string from one of the categories:
      #
      # * {#googlebot}
      # * {#chrome}
      # * {#firefox}
      # * {#edge}
      # * {#brave}
      # * {#safari}
      # * {#opera}
      # * {#ios}
      # * {#android}
      #
      # @yield [user_agent]
      #   If a block is given, it will be used to filter the User Agents
      #   before picking a random User Agent.
      #
      # @yieldparam [UserAgent] user_agent
      #   A User Agent from the category.
      #
      # @return [String, nil]
      #   A random `User-Agent` string from the category.
      #   Note, `nil` can be returned if the given block filter out all User
      #   Agents.
      #
      def self.random(&block)
        method = [
          # bots
          :googlebot,
          # browsers
          :chrome, :firefox, :edge, :brave, :safari, :opera,
          # mobile
          :ios, :android
        ].sample

        return send(method).random(&block)
      end
    end
  end
end
