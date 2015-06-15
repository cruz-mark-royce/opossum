class Question < ActiveRecord::Base

  belongs_to :survey, inverse_of: :questions

  has_many :answers

  validates :survey, presence: true
  validate :valid_question_type
  validates :value, presence: true
  validates :order, numericality: { only_integer: true }, uniqueness: {scope: :survey_id}, :on => :create

  private

  def valid_question_type
    valids = ['boolean', 'string', 'text']
    unless valids.include?(question_type)
      errors.add(:question_type, "is invalid")
    end
  end
end
