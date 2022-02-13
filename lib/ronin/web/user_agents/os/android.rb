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

require 'ronin/web/user_agents/data_dir'

module Ronin
  module Web
    module UserAgents
      module OS
        module Android
          # Known Android versions.
          VERSIONS = %w[
            10
            10.0
            11
            11.0
            12
            12.1
            4.0.4
            4.1.2
            4.2.2
            4.4.2
            4.4.4
            5.0
            5.0.2
            5.1
            5.1.1
            6.0
            6.0.1
            7.0
            7.1.1
            7.1.2
            8.0
            8.0.0
            8.1
            8.1.0
            9
            9.0
          ]

          # Architectures supported by Android.
          ARCHES = {
            arm:   'arm',
            arm64: 'arm_64',

            nil => nil
          }

          # Known Android devices.
          DEVICES = File.readlines(
            File.join(DATA_DIR,'android','devices.txt'), chomp: true
          )
        end
      end
    end
  end
end
