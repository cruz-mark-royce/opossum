require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # 2 surveys
  # each survey has 3 questions
  #

  setup do
    @survey1 = surveys(:one)
    @survey2 = surveys(:two)
    @submission1 = submissions(:one)
    @submission2 = submissions(:two)
    @submission3 = submissions(:three)
  end

  test "should require title" do
    survey1 = Survey.new
    survey2 = Survey.new(title: "")
    survey3 = Survey.new(title: "actual title")
    refute survey1.save
    refute survey2.save
    assert survey3.save
  end

  test "has questions" do
    assert_equal 3, @survey1.questions.count
    assert_equal 3, @survey2.questions.count
  end

  test "has submissions" do
    assert_equal 2, @survey1.submissions.count
    assert_equal 1, @survey2.submissions.count
  end

  test "has answers thru submissions" do
    assert_equal 6, @survey1.submissions.all.reduce(0){|sum, obj| sum + obj.answers.count}
    assert_equal 3, @survey2.submissions.all.reduce(0){|sum, obj| sum + obj.answers.count}
  end

  test "has answers thru questions" do
    assert_equal 6, @survey1.questions.all.reduce(0){|sum, obj| sum + obj.answers.count}
    assert_equal 3, @survey2.questions.all.reduce(0){|sum, obj| sum + obj.answers.count}
  end

  test "answers.count method works" do
    assert_equal 6, @survey1.answers.count
    assert_equal 3, @survey2.answers.count
  end
end
