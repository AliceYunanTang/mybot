class Picture < ApplicationRecord
  belongs_to :user, optional: true
  serialize :detail, JSON
end
