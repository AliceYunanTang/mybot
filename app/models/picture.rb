class Picture < ApplicationRecord
  belongs_to :user, optional: true
end
