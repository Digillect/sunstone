module Sunstone
  module Objects
    class Probe < BaseObject
      include ActionsOwner

      property :failure_threshold, Integer
      property :initial_delay_seconds, Integer
      property :period_seconds, Integer
      property :success_threshold, Integer
      property :timeout_seconds, Integer
    end
  end
end
