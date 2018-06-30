class Review < ApplicationRecord
  belongs_to :user

  validates_presence_of :text, :rating, :user_id
  validates_inclusion_of :rating, in: 1..10
end
