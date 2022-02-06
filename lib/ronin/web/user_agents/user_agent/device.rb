module Ronin
  module Web
    module UserAgents
      class UserAgent
        class Device

          # @return [String]
          attr_reader :family

          # @return [String, nil]
          attr_reader :model

          # @return [String, nil]
          attr_reader :brand

          #
          # Initializes the device.
          #
          # @param [String] family
          #
          # @param [String, nil] model
          #
          # @param [String, nil] brandh
          #
          def initialize(family,model,brand)
            @family = family
            @model  = model
            @brand  = brand
          end

          #
          # Retruns {#family}.
          #
          # @return [String]
          #
          def to_s
            @family.to_s
          end

          #
          # Retruns {#family}.
          #
          # @return [String]
          #
          def to_str
            @family.to_str
          end

        end
      end
    end
  end
end
