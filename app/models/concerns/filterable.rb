module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params, defaults = {})
      results = self.where(nil)
      defaults.as_json.deep_merge(filtering_params.as_json).each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end