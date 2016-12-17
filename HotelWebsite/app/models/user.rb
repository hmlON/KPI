class User < ApplicationRecord
  has_many :reservations;

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :password, :phone, :name
  validates_uniqueness_of :phone
end