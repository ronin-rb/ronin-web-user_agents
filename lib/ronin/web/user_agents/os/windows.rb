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
        #
        # @api private
        #
        module Windows
          # Common Windows versions.
          VERSIONS = {
            xp:    '5.2',
            vista: '6.0',
            7   => '6.1',
            8   => '6.2',
            8.1 => '6.3',
            10  => '10.0'
          }

          # Architectures supported by Windows.
          ARCHES = {
            wow64:  'WOW64',
            win64:  'Win64; x64',
            x86_64: 'Win64; x64',

            nil => nil
          }
        end
      end
    end
  end
end
