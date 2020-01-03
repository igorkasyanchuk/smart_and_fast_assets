class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    delegate :each, to: :all
  end
end
