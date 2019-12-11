require 'test_helper'
require 'sunstone/objects/persistent_volume_claim'

class PersistentVolumeClaimTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::PersistentVolumeClaim.new :test
  end

  def test_properties_and_methods
    assert_property sut, :spec

    assert_respond_to sut, :access_mode
    assert_respond_to sut, :access_modes
    assert_respond_to sut, :match_labels
    assert_respond_to sut, :storage_class_name
    assert_respond_to sut, :storage_limit
    assert_respond_to sut, :storage_request
  end

  def test_access_modes
    sut.access_mode :ReadWriteOnce

    assert_equal ['ReadWriteOnce'], sut.to_hash[:spec][:accessModes]
  end

  def test_storage_class_name
    sut.storage_class_name :slow

    assert_equal 'slow', sut.to_hash[:spec][:storageClassName]
  end

  def test_storage_requests
    sut.storage_request '8Gi'

    assert_equal '8Gi', sut.to_hash[:spec][:resources][:requests][:storage]
  end

  def test_serialization
    sut.access_mode :ReadWriteOnce
    sut.storage_class_name :slow
    sut.storage_request '5Gi'

    expected = {
      apiVersion: 'v1',
      kind: 'PersistentVolumeClaim',
      metadata: {
        name: 'test'
      },
      spec: {
        accessModes: ['ReadWriteOnce'],
        storageClassName: 'slow',
        resources: {
          requests: {
            storage: '5Gi'
          }
        }
      }
    }

    actual = sut.to_hash

    assert_equal_hash expected, actual
  end
end
