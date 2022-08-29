#
# ronin-web-user_agents - Yet another User-Agent string generator library.
#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/web/user_agents/os/windows'
require 'ronin/web/user_agents/os/mac_os'
require 'ronin/web/user_agents/os/linux'
require 'ronin/web/user_agents/os/android'
require 'ronin/web/user_agents/data_dir'

module Ronin
  module Web
    module UserAgents
      #
      # Represents all possible Firefox `User-Agent` strings.
      #
      # @see https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent/Firefox
      #
      module Firefox

        # The default `Gecko/...` version.
        #
        # @note: On desktop, the `Gecko/...` version is hardcoded to `20100101`
        DESKTOP_GECKO_VERSION = '20100101'

        # Encryption Strengths.
        #
        # @see https://developers.whatismybrowser.com/useragents/notes/what-does-u-mean-in-a-user-agent
        ENCRYPTION = {
          usa:  'U',
          international: 'I',
          none: 'N',
          no:   'N',

          nil => nil
        }

        # Common device types.
        DEVICE_TYPES = {
          mobile: 'Mobile',
          tablet: 'Tablet',

          nil => nil
        }

        #
        # Builds a new Firefox `User-Agent` string.
        #
        # @param [String] firefox_version
        #   The `rv:...` and `Firefox/...` version.
        #
        # @param [String, nil] lang
        #   The optional language identifier to add (ex: `en-GB`).
        #
        # @param [:usa, :international, :none, :no, nil] encryption
        #   The supported encryption strength.
        #
        # @param [:windows, :macos, :linux, :android] os
        #   The Operating System.
        #
        # @param [String, nil] os_version
        #   The Operating System version. Is required if `os:` is `:windows`,
        #   `:macos`, or `:android`.
        #
        # @param [:ubuntu, :fedora, :arch, String, nil] linux_distro
        #   The optional Linux Distro. Only supported if `os:` is `:linux`.
        #
        # @param [:x86_64, :x86, :i686, :aarch64, :arm64, :arm, nil] arch
        #   The hardware architecture. Can be omitted if `os:` is `:android`.
        #
        # @param [:mobile, :tablet, nil] device_type
        #   The optional device type.
        #
        # @return [String]
        #   The Firefox `User-Agent` string.
        #
        # @see https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent/Firefox
        #
        # @api public
        #
        def self.build(firefox_version: ,
                       lang: nil,
                       encryption: nil,
                       os: ,
                       os_version: nil,
                       linux_distro: nil,
                       arch: nil,
                       device_type: nil)
          case os
          when :windows
            unless os_version
              raise(ArgumentError,"os: :windows also requires an os_version: value")
            end

            build_windows(
              windows_version: os_version,
              arch:            arch,
              firefox_version: firefox_version
            )
          when :macos
            unless os_version
              raise(ArgumentError,"os: :macos also requires an os_version: value")
            end

            build_macos(
              arch:            arch || :intel,
              macos_version:   os_version,
              firefox_version: firefox_version
            )
          when :linux
            build_linux(
              encryption:      encryption,
              linux_distro:    linux_distro,
              arch:            arch,
              lang:            lang,
              firefox_version: firefox_version
            )
          when :android
            build_android(
              device_type:     device_type || :mobile,
              firefox_version: firefox_version
            )
          else
            raise(ArgumentError,"unsupported os: value (#{os.inspect})")
          end
        end

        # Known versions for the `rv:...` and `Firefox/...` values.
        KNOWN_VERSIONS = File.readlines(
          File.join(DATA_DIR,'firefox','versions.txt'), chomp: true
        )

        # Supported Operating Systems.
        SUPPORTED_OSES = [
          :windows,
          :macos,
          :linux,
          :android
        ]

        # Known OS versions grouped by OS.
        KNOWN_OS_VERSIONS = {
          windows: OS::Windows::VERSIONS.keys,
          macos:   OS::MacOS::VERSIONS,
          linux:   [],
          android: OS::Android::VERSIONS
        }

        # Supported architectures grouped by OS.
        SUPPORTED_OS_ARCHES = {
          windows: OS::Windows::ARCHES.keys,
          macos:   OS::MacOS::ARCHES.keys,
          linux:   OS::Linux::ARCHES.keys,
          android: OS::Android::ARCHES.keys
        }

        # Supported Linux Distros.
        #
        # @return [Array<Symbol, nil>]
        SUPPORTED_LINUX_DISTROS = OS::Linux::DISTROS.keys

        # Supported encryption strengths.
        #
        # @return [Array<Symbol, nil>]
        SUPPORTED_ENCRYPTION = ENCRYPTION.keys

        # IETF language tags (ex: `en-GB`).
        #
        # @return [Array<String>]
        KNOWN_LANGS = File.readlines(
          File.join(DATA_DIR,'firefox','langs.txt'), chomp: true
        )

        # Supported device types.
        #
        # @return [Array<Symbol, nil>]
        SUPPORTED_DEVICE_TYPES = DEVICE_TYPES.keys

        #
        # Generates a random Firefox `User-Agent` string.
        #
        # @param [String] firefox_version
        #   The `rv:...` and `Firefox/...` version.
        #
        # @param [:usa, :international, :none, :no, nil] encryption
        #   The supported encryption strength.
        #
        # @param [String, nil] lang
        #   The optional language identifier to add (ex: `en-GB`).
        #
        # @param [:windows, :macos, :linux, :android] os
        #   The Operating System.
        #
        # @param [String, nil] os_version
        #   The Operating System version. Is required if `os:` is `:windows`,
        #   `:macos`, or `:android`.
        #
        # @param [:ubuntu, :fedora, :arch, String, nil] linux_distro
        #   The optional Linux Distro. Only supported if `os:` is `:linux`.
        #
        # @param [:x86_64, :x86, :i686, :aarch64, :arm64, :arm, nil] arch
        #   The hardware architecture. Can be omitted if `os:` is `:android`.
        #
        # @param [:mobile, :tablet, nil] device_type
        #   The optional device type.
        #
        # @return [String]
        #   The random `User-Agent` string.
        #
        # @api public
        #
        def self.random(firefox_version: KNOWN_VERSIONS.sample,
                        encryption:      SUPPORTED_ENCRYPTION.sample,
                        lang:            KNOWN_LANGS.sample,
                        os:              SUPPORTED_OSES.sample,
                        os_version:      KNOWN_OS_VERSIONS[os].sample,
                        linux_distro:    SUPPORTED_LINUX_DISTROS.sample,
                        arch:            SUPPORTED_OS_ARCHES[os].sample,
                        device_type:     DEVICE_TYPES.keys.sample)
          build(
            firefox_version: firefox_version,
            os: os,
            os_version: os_version,
            device_type: device_type,
            linux_distro: linux_distro,
            arch: arch,
            lang: lang
          )
        end

        private

        #
        # Builds a Firefox `User-Agent` string for Windows.
        #
        # @param [String, nil] windows_version
        #   The Windows version.
        #
        # @param [:arm, :arm64, nil] arch
        #   The optional hardware architecture.
        #
        # @param [String] firefox_version
        #   The `Firefox/...` version.
        #
        # @return [String]
        #   A Firefox `User-Agent` string For Windows.
        #
        def self.build_windows(windows_version: , arch: , firefox_version: )
          windows_version = OS::Windows::VERSIONS.fetch(windows_version,windows_version)
          windows_arch    = OS::Windows::ARCHES.fetch(arch)

          extensions = "Windows NT #{windows_version}"
          extensions << "; #{windows_arch}" if windows_arch
          extensions << "; rv:#{firefox_version}"

          return "Mozilla/5.0 (#{extensions}) Gecko/#{DESKTOP_GECKO_VERSION} Firefox/#{firefox_version}"
        end

        #
        # Builds a Firefox `User-Agent` string for macOS.
        #
        # @param [:intel] arch
        #   The optional hardware architecture.
        #
        # @param [String, nil] macos_version
        #   The macOS version.
        #
        # @param [String] firefox_version
        #   The `Firefox/...` version.
        #
        # @return [String]
        #   A Firefox `User-Agent` string For macOS.
        #
        def self.build_macos(arch: :intel, macos_version: , firefox_version: )
          macos_arch = OS::MacOS::ARCHES.fetch(arch)

          extensions = "Macintosh; #{macos_arch} Mac OS X #{macos_version}"
          extensions << "; rv:#{firefox_version}"

          return "Mozilla/5.0 (#{extensions}) Gecko/#{DESKTOP_GECKO_VERSION} Firefox/#{firefox_version}"
        end

        #
        # Builds a Firefox `User-Agent` string for Linux.
        #
        # @param [:usa, :international, :none, :no, nil] encryption
        #   The optional encryption strength to set.
        #
        # @param [:ubuntu, :fedora, :arch, String, nil] linux_distro
        #   The Linux Distro name.
        #
        # @param [:arm, :arm64, nil] arch
        #   The optional hardware architecture.
        #
        # @param [String, nil] lang
        #   The optional language identifier to add (ex: `en-GB`).
        #
        # @param [String] firefox_version
        #   The `Firefox/...` version.
        #
        # @return [String]
        #   A Firefox `User-Agent` string For Linux.
        #
        def self.build_linux(encryption: nil, linux_distro: nil, arch: nil, lang: nil, firefox_version: )
          encryption_flag = ENCRYPTION.fetch(encryption)
          linux_arch    = OS::Linux::ARCHES[arch]
          linux_distro  = OS::Linux::DISTROS.fetch(linux_distro,linux_distro)

          extensions = "X11"
          extensions << "; #{encryption_flag}" if encryption_flag
          extensions << "; #{linux_distro}"  if linux_distro
          extensions << "; Linux"
          extensions << " #{linux_arch}" if linux_arch
          extensions << "; #{lang}" if lang
          extensions << "; rv:#{firefox_version}"

          return "Mozilla/5.0 (#{extensions}) Gecko/#{DESKTOP_GECKO_VERSION} Firefox/#{firefox_version}"
        end

        #
        # Builds a Firefox `User-Agent` string for Android.
        #
        # @param [:mobile, :tablet] device_type
        #   The optional Android device.
        #
        # @param [String] firefox_version
        #   The `Firefox/...` version.
        #
        # @return [String]
        #   A Firefox `User-Agent` string For Android.
        #
        def self.build_android(device_type: :mobile, firefox_version: )
          device_type = DEVICE_TYPES.fetch(device_type)

          extensions = "Android; #{device_type}"
          extensions << "; rv:#{firefox_version}"

          return "Mozilla/5.0 (#{extensions}) Gecko/#{firefox_version} Firefox/#{firefox_version}"
        end

      end
    end
  end
end
