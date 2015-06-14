class Question < ActiveRecord::Base
  belongs_to :survey

  attr_writer :answers_attributes

  has_many :answers
  accepts_nested_attributes_for :answers

  validates :survey_id, presence: true
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
