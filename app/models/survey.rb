class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  accepts_nested_attributes_for :questions,
      reject_if: proc { |attributes| attributes['value'].blank? },
      allow_destroy: true
  validates :title, presence: true
end
