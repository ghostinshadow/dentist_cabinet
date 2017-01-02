class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :create_dictionaries

  has_many :patients
  has_many :dictionaries

  private

  def create_dictionaries
    Dictionary.create_for_user(self)
  end
end
