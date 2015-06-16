class Survey < ActiveRecord::Base
  belongs_to :user

  has_many :questions, inverse_of: :survey
  accepts_nested_attributes_for :questions,
      reject_if: proc { |attributes| attributes['value'].blank? },
      allow_destroy: true

  has_many :answers, through: :questions

  has_many :submissions

  validates :title, presence: true

  # validate :at_least_one_question
  #
  # def at_least_one_question
  #   if self.questions.count < 1 && !self.published
  #     errors.add(:_, "Must have at least one question to publish")
  #   end
  # end
end
