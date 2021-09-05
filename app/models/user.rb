# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
class User < ApplicationRecord
  before_validation :strip_whitespace
  has_secure_password
  validates :name, uniqueness: true, presence: true

  private
    def strip_whitespace
      self.name = self.name.strip unless self.name.nil?
      self.password = self.password.strip unless self.password.nil?
    end
end
