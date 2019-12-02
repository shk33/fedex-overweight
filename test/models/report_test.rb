require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "should not save report without summary" do
    report = Report.new
    assert_not report.save
  end

  test "should save report with summary" do
    report = Report.new
    report.stringified_summary = "FooBar"
    assert report.save
  end
end
