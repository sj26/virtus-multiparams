require "virtus"
require "virtus/multiparams/version"

module Virtus
  module Multiparams
    def self.included(base)
      base.attribute_set.singleton_class.prepend AttributeSetExtension
    end

    module AttributeSetExtension
      def coerce(attributes)
        super(attributes).tap do |attributes|
          multiparams = Hash.new { |hash, key| hash[key] = {} }

          attributes.each do |(key, value)|
            if /\A(?<name>.+)\((?<offset>[0-9]+)(?<cast>[if])?\)\Z/ =~ key
              attributes.delete(key)

              unless attributes.include? name
                offset = offset.to_i
                value = value.send("to_#{cast}") if cast
                multiparams[name][offset] = value
              end
            end
          end

          multiparams.each do |name, values|
            array = Array.new(values.keys.max)

            values.each do |offset, value|
              array[offset - 1] = value
            end

            # Virus::Attribute has a primitive type which might be Date, Time, DateTime, etc.
            attribute = self[name]

            attributes[name] =
              if attribute.primitive <= Date || attribute.primitive <= Time
                # Basic convesion is enough, Virtus invokes `to_date[time]`
                # Also, lololol timezones
                Time.new(*array[0...6]) unless array[0...3].any? { |param| param.nil? || param == 0 }
              else
                array
              end
          end
        end
      end
    end
  end
end
