module Ronin
  module Web
    module UserAgents
      class UserAgent
        class Version

          # The version string.
          #
          # @return [String]
          attr_reader :string

          # Major version number.
          #
          # @return [Integer]
          attr_reader :major

          # Minor version number.
          #
          # @return [Integer]
          attr_reader :minor

          # Patch version number.
          #
          # @return [Integer, nil]
          attr_reader :patch

          # Patch-minor version number.
          #
          # @return [Integer, nil]
          attr_reader :patch_minor

          #
          # Initializes the version.
          #
          # @param [String] string
          #   The version string.
          #
          # @param [Integer] major
          #   The major version number.
          #
          # @param [Integer] minor
          #   The minor version number.
          #
          # @param [Integer, nil] patch
          #   The patch version number.
          #
          # @param [Integer, nil] patch_minor
          #   The patch-minor version number.
          #
          def initialize(string,major,minor,patch=nil,patch_minor=nil)
            @string = string

            @major = major
            @minor = minor
            @patch = patch
            @patch_minor = patch_minor
          end

          #
          # Retruns the {#version}.
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
  end
end
