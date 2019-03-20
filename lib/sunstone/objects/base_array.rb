require 'forwardable'
require 'sunstone/objects/parentable'

module Sunstone
  module Objects
    class BaseArray
      extend Forwardable
      include Enumerable
      include Parentable

      def_delegators :@items,
                     :inspect, :to_s, :[], :at, :fetch, :first, :last, :each, :each_index, :reverse_each,
                     :length, :size, :empty?, :find_index, :index, :rindex, :join, :sort, :collect,
                     :map, :select, :values_at, :reject, :zip, :include?, :slice, :count, :take, :take_while,
                     :drop, :drop_while
      def initialize
        @items = []
      end

      def <<(item)
        item.__parent = self if item.is_a? Parentable

        @items << item
      end

      def push(item, *items)
        self << item

        items.each do |i|
          self << i
        end
      end

      alias append push
    end
  end
end
