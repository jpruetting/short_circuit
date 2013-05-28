require "short_circuit/presentable"

module ActiveRecordExtension

  extend ActiveSupport::Concern

  included do
    include ShortCircuit::Presentable
  end

end

ActiveRecord::Base.send(:include, ActiveRecordExtension)
