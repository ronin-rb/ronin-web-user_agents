#
# ronin-web-user_agents - Yet another User-Agent string generator library.
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

module Ronin
  module Web
    module UserAgents
      module OS
        module MacOS
          # Known macOS versions.
          VERSIONS = %w[
            10.10
            10.10.3
            10.10.4
            10.11.6
            10.12.0
            10.12.1
            10.12.6
            10.13.4
            10.13.6
            10.14.0
            10.14.1
            10.14.2
            10.14.5
            10.14.6
            10.14.8
            10.15.1
            10.15.2
            10.15.4
            10.15.6
            10.15.7
            10.16
            10.16.0
            10.31.7
            10.4
            10.55
            10.7.0
            11.0.0
            11.15
            11.55
            11.6.3
            12.2.0
            16.55
          ]

          # Known macOS versions, but in underscored notation.
          VERSIONS_UNDERSCORED = {
            '10.10'   => '10_10',
            '10.10.3' => '10_10_3',
            '10.10.4' => '10_10_4',
            '10.11.6' => '10_11_6',
            '10.12.0' => '10_12_0',
            '10.12.1' => '10_12_1',
            '10.12.6' => '10_12_6',
            '10.13.4' => '10_13_4',
            '10.13.6' => '10_13_6',
            '10.14.0' => '10_14_0',
            '10.14.1' => '10_14_1',
            '10.14.2' => '10_14_2',
            '10.14.5' => '10_14_5',
            '10.14.6' => '10_14_6',
            '10.14.8' => '10_14_8',
            '10.15.1' => '10_15_1',
            '10.15.2' => '10_15_2',
            '10.15.4' => '10_15_4',
            '10.15.6' => '10_15_6',
            '10.15.7' => '10_15_7',
            '10.16'   => '10_16',
            '10.16.0' => '10_16_0',
            '10.31.7' => '10_31_7',
            '10.4'    => '10_4',
            '10.55'   => '10_55',
            '10.7.0'  => '10_7_0',
            '11.0.0'  => '11_0_0',
            '11.15'   => '11_15',
            '11.55'   => '11_55',
            '11.6.3'  => '11_6_3',
            '12.2.0'  => '12_2_0',
            '16.55'   => '16_55',
          }
          VERSIONS_UNDERSCORED.default_proc = ->(hash,version) {
            version.tr('.','_')
          }

          # Architectures supporte by macOS.
          ARCHES = {
            intel:  'Intel',
            x86_64: 'Intel'
          }

        end
      end
    end
  end
end
