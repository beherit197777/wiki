class Article < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  validates :title, presence: true
  validates :content, presence: true
end
