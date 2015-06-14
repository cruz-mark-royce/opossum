class Survey < ActiveRecord::Base
  belongs_to :user

  attr_writer :questions_attributes

  has_many :questions
  accepts_nested_attributes_for :questions,
      reject_if: proc { |attributes| attributes['value'].blank? },
      allow_destroy: true

  has_many :answers, through: :questions

  has_many :submissions
  validates :title, presence: true


end
