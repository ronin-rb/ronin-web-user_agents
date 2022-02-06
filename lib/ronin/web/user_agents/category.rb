require 'ronin/web/user_agents/user_agent'

require 'csv'

module Ronin
  module Web
    module UserAgents
      class Category

        include Enumerable

        # Path to the `data/` directory.
        DATA_DIR = File.expand_path('../../../../data',__dir__)

        # Path to the `data/user_agents/` directory.
        USER_AGENTS_DIR = File.join(DATA_DIR,'user_agents')

        # The pre-parsed `User-Agent` strings.
        #
        # @return [Array<UserAgent>]
        attr_reader :user_agents

        #
        # Initializes the category.
        #
        # @param [Array<UserAgent>] user_agents
        #   The pre-parsed User Agents belonging to the category.
        #
        def initialize(user_agents)
          @user_agents = user_agents
        end

        #
        # Parses a `.csv` file containing pre-parsed `User-Agent` strings.
        #
        # @param [String] path
        #   The path to the `.csv` file.
        #
        # @yield [user_agent]
        #   If a block is given, it will be passed each pre-parsed User Agent.
        #
        # @yieldparam [UserAgent] user_agent
        #   A pre-parsed User Agent, containing both the raw `User-Agent`
        #   string and each parsed field.
        #
        # @return [Enumerator]
        #   If no block is given, an Enumerator object will be returned.
        #
        # @api private
        #
        def self.parse(path)
          return enum_for(__method__,path) unless block_given?

          csv = CSV.open(path, headers: true)

          csv.each do |row|
            user_agent_string = row[0]
            user_agent_family = row[1]
            user_agent_version_string = row[2]
            user_agent_version_major  = row[3]
            user_agent_version_minor  = row[4]
            user_agent_version_patch  = row[5]
            user_agent_version_patch_minor = row[6]

            user_agent_os_family  = row[7]
            user_agent_os_version_string = row[8]
            user_agent_os_version_major  = row[9]
            user_agent_os_version_minor  = row[10]
            user_agent_os_version_patch  = row[11]
            user_agent_os_version_patch_minor = row[12]

            user_agent_device_family = row[13]
            user_agent_device_model  = row[14]
            user_agent_device_brand  = row[15]

            user_agent_version = if user_agent_version_string
                                   UserAgent::Version.new(
                                     user_agent_version_string,
                                     user_agent_version_major,
                                     user_agent_version_minor,
                                     user_agent_version_patch,
                                     user_agent_version_patch_minor
                                   )
                                 end

            user_agent_os_version = if user_agent_os_version_string
                                      UserAgent::Version.new(
                                        user_agent_os_version_string,
                                        user_agent_os_version_major,
                                        user_agent_os_version_minor,
                                        user_agent_os_version_patch,
                                        user_agent_os_version_patch_minor
                                      )
                                    end

            yield UserAgent.new(
              user_agent_string,
              user_agent_family,
              user_agent_version,
              UserAgent::OS.new(
                user_agent_os_family,
                user_agent_os_version
              ),
              UserAgent::Device.new(
                user_agent_device_family,
                user_agent_device_model,
                user_agent_device_brand
              )
            )
          end
        end

        #
        # Loads pre-parsed `User-Agent` strings for the given category name.
        #
        # @param [String] name
        #   The category name to load.
        #
        # @return [Category]
        #   The loaded category.
        #
        # @api private
        #
        def self.load(name)
          path = File.join(USER_AGENTS_DIR,"#{name}.csv")

          return new(parse(path).to_a)
        end

        #
        # Returns a random `User-Agent` string.
        #
        # @param [Regexp] regexp
        #   An optional regula rexpression may be given to filter down
        #   User Agents before picking a random User Agent.
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
        #   Note, `nil` can be returned if the given regexp or block filtered
        #   out all User Agents.
        #
        # @example
        #   user_agent = Ronin::Web::UserAgents.chrome.random
        #
        # @example using a regular expression
        #   user_agent = Ronin::Web::UserAgents.chrome.random(/Linux/i)
        #
        # @example using a block:
        #   user_agent = Ronin::Web::UserAgents.chrome.random { |ua|
        #     ua.os.family == 'Linux'
        #   }
        #
        # @api public
        #
        def random(regexp=nil,&block)
          user_agents = if    regexp then @user_agents.grep(regexp)
                        elsif block  then @user_agents.select(&block)
                        else              @user_agents
                        end

          if (random_user_agent = user_agents.sample)
            return random_user_agent.string
          end
        end

        #
        # Enumerates over every pre-parsed `User-Agent` string in the category.
        #
        # @yield [user_agent]
        #
        # @yieldparam [UserAgent] user_agent
        #
        # @return [Enumerator]
        #   If no block is given, an Enumerator object will be returned.
        #
        # @api public
        #
        def each(&block)
          @user_agents.each(&block)
        end

        #
        # Combines the category with another category.
        #
        # @param [Category] other_category
        #   The other category to add.
        #
        # @return [Category]
        #   The combined category.
        #
        # @api public
        #
        def +(other_category)
          new(@user_agents + other_category.uesr_agents)
        end

      end
    end
  end
end
