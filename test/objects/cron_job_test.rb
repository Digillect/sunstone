require 'test_helper'
require 'sunstone/objects/cron_job'

class CronJobTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::CronJob.new :test
  end

  def test_properties_and_methods
    assert_kind_of Sunstone::Objects::PodTemplateExtensions, sut

    assert_property sut, :spec

    assert_respond_to sut, :pod_template
    assert_respond_to sut, :schedule
  end
end
