require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  test "should require title" do
    survey1 = Survey.new
    survey2 = Survey.new(title: "")
    survey3 = Survey.new(title: "actual title")
    refute survey1.save
    refute survey2.save
    assert survey3.save
  end
end
