# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_posts_on_created_at              (created_at)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  PAGINATION_DEFAULT_PAGE = 1
  PAGINATION_DEFAULT_ITEMS = 10

  belongs_to :user
  validates :description, presence: true
  has_one_attached :image
end
