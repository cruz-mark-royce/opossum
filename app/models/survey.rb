class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  accepts_nested_attributes_for :questions,
      reject_if: proc { |attributes| attributes['order'].blank? && attributes['value'].blank? }
  validates :title, presence: true
end
