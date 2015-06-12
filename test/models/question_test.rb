require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @survey1 = surveys(:one)
    @survey2 = surveys(:two)
  end

  test "should require correct question type" do
    q1 = Question.new(survey_id: @survey1.id, order: 1, value: "question?")
    q2 = Question.new(survey_id: @survey1.id, order: 2, value: "question?", question_type: "not_a_data_type")
    q3 = Question.new(survey_id: @survey1.id, order: 3, value: "question?", question_type: "boolean")
    q4 = Question.new(survey_id: @survey1.id, order: 4, value: "question?", question_type: "string")
    q5 = Question.new(survey_id: @survey1.id, order: 5, value: "question?", question_type: "text")
    refute q1.save
    refute q2.save
    assert q3.save
    assert q4.save
    assert q5.save
  end

  test "should require value" do
    q1 = Question.new(survey_id: @survey1.id, order: 1, question_type: "string", value: "")
    q2 = Question.new(survey_id: @survey1.id, order: 2, question_type: "string", value: "question?")
    refute q1.save
    assert q2.save
  end

  test "should require order" do
    q1 = Question.new(survey_id: @survey1.id, question_type: "string", value: "question?")
    q2 = Question.new(survey_id: @survey1.id, question_type: "string", value: "question?", order: 1)
    refute q1.save
    assert q2.save
  end

  test "should require order to be unique, but only for that survey" do
    q1 = Question.new(question_type: "string", value: "question?", survey_id: @survey1.id, order: 1)
    q2 = Question.new(question_type: "string", value: "question?", survey_id: @survey1.id, order: 2)
    q3 = Question.new(question_type: "string", value: "question?", survey_id: @survey1.id, order: 2)
    q4 = Question.new(question_type: "string", value: "question?", survey_id: @survey2.id, order: 2) #survey number 2
    q5 = Question.new(question_type: "string", value: "question?", survey_id: @survey1.id, order: 3)
    assert q1.save
    assert q2.save
    refute q3.save
    assert q4.save
    assert q5.save
  end

  test "should not require require but it does exist" do
    q1 = Question.create(question_type: "string", value: "question?", survey_id: @survey1.id, order: 1, require: true)
    q2 = Question.create(question_type: "string", value: "question?", survey_id: @survey1.id, order: 2, require: false)
    assert q1.require
    refute q2.require
  end
end
