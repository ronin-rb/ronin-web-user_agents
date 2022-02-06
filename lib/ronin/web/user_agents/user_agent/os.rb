require 'ronin/web/user_agents/user_agent/version'

module Ronin
  module Web
    module UserAgents
      class UserAgent
        class OS

          # @return [String]
          attr_reader :family

          # @return [Version]
          attr_reader :version

          #
          # @param [String] family
          #
          # @param [Version, nil] version
          #
          def initialize(family,version=nil)
            @family  = family
            @version = version
          end

          #
          # Retruns {#family} and/or {#version}.
          #
          # @return [String]
          #
          def to_s
            if @version
              "#{@family} #{@version}"
            else
              @family.to_s
            end
          end

          alias to_str to_s

        end
      end
    end
  end
end
