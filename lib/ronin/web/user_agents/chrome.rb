# frozen_string_literal: true
#
# ronin-web-user_agents - Yet another User-Agent string generator library.
#
# Copyright (c) 2006-2026 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require_relative 'os/windows'
require_relative 'os/mac_os'
require_relative 'os/linux'
require_relative 'os/android'

module Ronin
  module Web
    module UserAgents
      #
      # Represents every possible Chrome `User-Agent` string.
      #
      module Chrome
        #
        # Builds a new Chrome `User-Agent` string.
        #
        # @param [String] chrome_version
        #   The `Chrome/...` version.
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
        # @param [:x86_64, :x86, :i686, :aarch64, :arm64, :arm] arch
        #   The hardware architecture. Can be omitted if `os:` is `:android`.
        #
        # @param [String, nil] android_device
        #   The Android device. Only supported if `os:` is `:android`.
        #
        # @return [String]
        #   The new `User-Agent` string.
        #
        # @api public
        #
        def self.build(chrome_version: ,
                       os: ,
                       os_version: nil,
                       linux_distro: nil,
                       arch: nil,
                       android_device: nil)
          case os
          when :windows
            unless os_version
              raise(ArgumentError,"os: :windows also requires an os_version: value")
            end

            build_windows(
              chrome_version:  chrome_version,
              windows_version: os_version,
              arch:            arch
            )
          when :macos
            unless os_version
              raise(ArgumentError,"os: :macos also requires an os_version: value")
            end

            build_macos(
              chrome_version: chrome_version,
              macos_version:  os_version,
              arch:           arch || :intel
            )
          when :linux
            unless arch
              raise(ArgumentError,"os: :linux also requires an arch: value")
            end

            build_linux(
              chrome_version: chrome_version,
              linux_distro:   linux_distro,
              arch:           arch
            )
          when :android
            unless os_version
              raise(ArgumentError,"os: :android also requires an os_version: value")
            end

            build_android(
              chrome_version:  chrome_version,
              android_version: os_version,
              arch:            arch,
              android_device:  android_device
            )
          else
            raise(ArgumentError,"unsupported os: value (#{os.inspect})")
          end
        end

        # Known Chrome versions
        KNOWN_VERSIONS = File.readlines(
          File.join(DATA_DIR,'chrome','versions.txt'), chomp: true
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
        SUPPORTED_LINUX_DISTROS = OS::Linux::DISTROS.keys

        #
        # Generates a random Chrome `User-Agent` string.
        #
        # @param [String] chrome_version
        #   The `Chrome/...` version.
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
        # @param [:x86_64, :x86, :i686, :aarch64, :arm64, :arm] arch
        #   The hardware architecture. Can be omitted if `os:` is `:android`.
        #
        # @param [String, nil] android_device
        #   The Android device. Only supported if `os:` is `:android`.
        #
        # @return [String]
        #   The random `User-Agent` string.
        #
        # @api public
        #
        def self.random(chrome_version: KNOWN_VERSIONS.sample,
                        os:             SUPPORTED_OSES.sample,
                        os_version:     KNOWN_OS_VERSIONS[os].sample,
                        linux_distro:   SUPPORTED_LINUX_DISTROS.sample,
                        arch:           SUPPORTED_OS_ARCHES[os].sample,
                        android_device: OS::Android::DEVICES.sample)
          build(
            chrome_version: chrome_version,
            os: os,
            os_version: os_version,
            linux_distro: linux_distro,
            arch: arch,
            android_device: android_device
          )
        end

        #
        # Builds a Chrome `User-Agent` string for Windows.
        #
        # @param [String] chrome_version
        #   The `Chrome/...` version.
        #
        # @param [String, nil] windows_version
        #   The Windows version.
        #
        # @param [:x86_64, :x86, :i686, :aarch64, :arm64, :arm] arch
        #   The hardware architecture.
        #
        # @return [String]
        #   The Chrome `User-Agent` string for Windows.
        #
        def self.build_windows(chrome_version: , windows_version: , arch: nil)
          windows_version = OS::Windows::VERSIONS.fetch(windows_version,windows_version)
          windows_arch    = OS::Windows::ARCHES.fetch(arch) do
                              raise(ArgumentError,"unknown arch: value (#{arch.inspect})")
                            end

          extensions = "Windows NT #{windows_version}"
          extensions << "; #{windows_arch}" if windows_arch

          return "Mozilla/5.0 (#{extensions}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36"
        end

        #
        # Builds a Chrome `User-Agent` string for macOS.
        #
        # @param [String] chrome_version
        #   The `Chrome/...` version.
        #
        # @param [String, nil] macos_version
        #   The macOS version.
        #
        # @param [:x86_64, :x86, :i686, :aarch64, :arm64, :arm] arch
        #   The hardware architecture.
        #
        # @return [String]
        #   The Chrome `User-Agent` string for macOS.
        #
        def self.build_macos(chrome_version: , macos_version: , arch: :intel)
          macos_version = OS::MacOS::VERSIONS_UNDERSCORED[macos_version]
          macos_arch    = OS::MacOS::ARCHES.fetch(arch) do
                            raise(ArgumentError,"unknown arch: value (#{arch.inspect})")
                          end

          return "Mozilla/5.0 (Macintosh; #{macos_arch} Mac OS X #{macos_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36"
        end

        #
        # Builds a Chrome `User-Agent` string for Linux.
        #
        # @param [String] chrome_version
        #   The `Chrome/...` version.
        #
        # @param [:x86_64, :x86, :i686, :aarch64, :arm64] arch
        #   The hardware architecture.
        #
        # @param [:ubuntu, :fedora, :arch, String, nil] linux_distro
        #   The optional Linux Distro.
        #
        # @return [String]
        #   The Chrome `User-Agent` string for Linux.
        #
        def self.build_linux(chrome_version: , arch: , linux_distro: nil)
          linux_distro = OS::Linux::DISTROS.fetch(linux_distro,linux_distro)
          linux_arch   = OS::Linux::ARCHES.fetch(arch) do
                           raise(ArgumentError,"unknown arch: value (#{arch.inspect})")
                         end

          extensions = String.new("X11")
          extensions << "; #{linux_distro}" if linux_distro
          extensions << "; Linux #{linux_arch}"

          return "Mozilla/5.0 (#{extensions}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36"
        end

        #
        # Builds a Chrome `User-Agent` string for Android.
        #
        # @param [String] chrome_version
        #   The `Chrome/...` version.
        #
        # @param [String, nil] android_version
        #   The Android version.
        #
        # @param [:arm, :arm64, nil] arch
        #   The optional hardware architecture.
        #
        # @param [String, nil] android_device
        #   The optional Android device.
        #
        # @return [String]
        #   The Chrome `User-Agent` string for Android.
        #
        def self.build_android(chrome_version: , android_version: , arch: nil, android_device: nil)
          arch = OS::Android::ARCHES.fetch(arch)

          extensions = String.new("Linux")
          extensions << "; #{arch}" if arch
          extensions << "; Android #{android_version}"
          extensions << "; #{android_device}" if android_device

          return "Mozilla/5.0 (#{extensions}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36"
        end
      end
    end
  end
end
