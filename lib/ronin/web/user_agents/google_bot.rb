# frozen_string_literal: true
#
# ronin-web-user_agents - Yet another User-Agent string generator library.
#
# Copyright (c) 2006-2024 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/web/user_agents/chrome'

module Ronin
  module Web
    module UserAgents
      #
      # Represents every possible `GoogleBot` `User-Agent` string.
      #
      module GoogleBot
        # `GoogleBot` version
        VERSION = '2.1'

        # `GoogleBot' URL.
        URL = 'http://www.google.com/bot.html'

        # The Android version which `GoogleBot` Mobile uses.
        ANDROID_VERSION = '6.0.1'

        # The Android device which `GoogleBot` Mobile uses.
        ANDROID_DEVICE = 'Nexus 5X Build/MMB29P'

        #
        # Builds a `GoogleBot` `User-Agent` string.
        #
        # @param [:search, :image, :video] crawler
        #   The type of `GoogleBot`.
        #
        # @param [:desktop, :mobile, nil] compatible
        #   Indicates whether to return a `(compatible: GoogleBot/...)`
        #   `User-Agent` string.
        #
        # @param [String, nil] chrome_version
        #   The optional Chrome version to include. Only is used when
        #   `compatible: true` is given.
        #
        # @return [String]
        #   The `GoogleBot` `User-Agent` string.
        #
        # @raise [ArgumentError]
        #   An unsupported `crawler:` or `compatible:` value was given.
        #
        # @see https://developers.google.com/search/docs/advanced/crawling/overview-google-crawlers
        #
        # @api public
        #
        def self.build(crawler: :search, compatible: nil, chrome_version: nil)
          case crawler
          when :image
            "Googlebot-Image/1.0"
          when :video
            "Googlebot-Video/1.0"
          when :search
            case compatible
            when :desktop
              googlebot = "GoogleBot/#{VERSION}; +#{URL}"

              if chrome_version
                "Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; #{googlebot}) Chrome/#{chrome_version} Safari/537.36"
              else
                "Mozilla/5.0 (compatible; #{googlebot})"
              end
            when :mobile
              unless chrome_version
                raise(ArgumentError,"compatible: :mobile also requires the chrome_version: keyword argument")
              end

              "Mozilla/5.0 (Linux; Android #{ANDROID_VERSION}; #{ANDROID_DEVICE}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36 (compatible; GoogleBot/#{VERSION}; +#{URL})"
            when nil
              "GoogleBot/#{VERSION} (+#{URL})"
            else
              raise(ArgumentError,"unsupported compatible: value (#{compatible.inspect})")
            end
          else
            raise(ArgumentError,"unsupported crawler: value (#{crawler.inspect})")
          end
        end

        # Supported `crawler:` values.
        SUPPORTED_CRAWLERS = [:search, :image, :video]

        # Supported `compatible:` values.
        SUPPORTED_COMPATIBILITY_MODES = [:desktop, :mobile, nil]

        # Known Chrome versions.
        #
        # @return [Array<String>]
        KNOWN_CHROME_VERSIONS = Chrome::KNOWN_VERSIONS

        #
        # Builds a random `GoogleBot` `User-Agent` string.
        #
        # @param [:search, :image, :video] crawler
        #   The type of `GoogleBot`.
        #
        # @param [:desktop, :mobile, nil] compatible
        #   Indicates whether to return a `(compatible: GoogleBot/...)`
        #   `User-Agent` string.
        #
        # @param [String, nil] chrome_version
        #   The optional Chrome version to include.
        #
        # @return [String]
        #   The `GoogleBot` `User-Agent` string.
        #
        # @api public
        #
        def self.random(crawler:        SUPPORTED_CRAWLERS.sample,
                        compatible:     SUPPORTED_COMPATIBILITY_MODES.sample,
                        chrome_version: KNOWN_CHROME_VERSIONS.sample)
          build(
            crawler:        crawler,
            compatible:     compatible,
            chrome_version: chrome_version
          )
        end
      end
    end
  end
end
