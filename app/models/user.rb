class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :api
  has_many :reviews, dependent: :destroy
  
  rolify

  def admin?
    has_role?(:admin)
  end

  def expert?
    has_role?(:expert)
  end

  def client?
    has_role?(:client)
  end
end
