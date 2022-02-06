require 'ronin/web/user_agents/user_agent/version'
require 'ronin/web/user_agents/user_agent/os'
require 'ronin/web/user_agents/user_agent/device'

module Ronin
  module Web
    module UserAgents
      class UserAgent

        # The `User-Agent` string.
        #
        # @return [String]
        attr_reader :string

        # The agent family.
        #
        # @return [String]
        attr_reader :family

        # The agent version.
        #
        # @return [Version]
        attr_reader :version

        # OS information.
        #
        # @return [OS]
        attr_reader :os

        # Device information.
        #
        # @return [Device]
        attr_reader :device

        #
        # Initializes a pre-parsed `User-Agent` tring.
        #
        # @param [String] string
        #   The `User-Agent` string.
        #
        # @param [String] family
        #   The agent family.
        #
        # @param [String, nil] version
        #   The agent version.
        #
        # @param [OS] os
        #   The OS information.
        #
        # @param [Device] device
        #   The device information.
        #
        def initialize(string,family,version,os,device)
          @string = string

          @family  = family
          @version = version
          @os      = os
          @device  = device
        end
      end

      #
      # Compares the given regexp against {#string}.
      #
      # @param [Regexp] regexp
      #
      # @return [Integer, nil]
      # 
      def =~(regexp)
        @string =~ regexp
      end

      #
      # Compares the given pattern against {#string}.
      #
      # @param [Regexp, String] pattern
      #
      # @return [MatchData, nil]
      #
      def match(pattern)
        @string.match(pattern)
      end

      #
      # Tests if the given substring exists in {#string}.
      #
      # @param [String] substring
      #
      # @return [Boolean]
      #
      def include?(substring)
        @string.include?(substring)
      end

      #
      # Returns {#string}.
      #
      # @return [String]
      #
      def to_s
        @string.to_s
      end

      alias to_str to_s

    end
  end
end
