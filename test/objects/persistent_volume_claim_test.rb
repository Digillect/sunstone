require 'test_helper'
require 'sunstone/objects/persistent_volume_claim'

class PersistentVolumeClaimTest < Minitest::Test
  def setup
    @sut = Sunstone::Objects::PersistentVolumeClaim.new :test
  end

  def test_access_modes
    @sut.access_mode :ReadWriteOnce

    assert_equal ['ReadWriteOnce'], @sut.to_hash[:spec][:accessModes]
  end

  def test_storage_class_name
    @sut.storage_class_name :slow

    assert_equal 'slow', @sut.to_hash[:spec][:storageClassName]
  end

  def test_storage_requests
    @sut.storage_request '8Gi'

    assert_equal '8Gi', @sut.to_hash[:spec][:resources][:request][:storage]
  end

  def test_serialization
    @sut.access_mode :ReadWriteOnce
    @sut.storage_class_name :slow
    @sut.storage_request '5Gi'

    expected = {
      apiVersion: 'core/v1',
      kind: 'PersistentVolumeClaim',
      metadata: {
        name: 'test'
      },
      spec: {
        accessModes: ['ReadWriteOnce'],
        storageClassName: 'slow',
        resources: {
          request: {
            storage: '5Gi'
          }
        }
      }
    }

    assert_equal_hash expected, @sut.to_hash
  end
end
