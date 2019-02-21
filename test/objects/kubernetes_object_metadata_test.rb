require 'test_helper'

class KubernetesObjectMetadataTest < Minitest::Test
  def test_initialization
    sut = Sunstone::Objects::KubernetesObjectMetadata.new

    assert_instance_of Hash, sut.labels
    assert_instance_of Hash, sut.annotations
    assert_instance_of Array, sut.finalizers

    assert_nil sut.name
  end

  def test_initialization_with_name
    sut = Sunstone::Objects::KubernetesObjectMetadata.new :test

    assert_equal :test, sut.name
  end

  def test_emptiness_checker_for_empty_metadata
    sut = Sunstone::Objects::KubernetesObjectMetadata.new

    assert_empty sut
  end

  def test_empty_for_nonempty_metadata
    sut = Sunstone::Objects::KubernetesObjectMetadata.new

    sut.labels[:test] = :test

    refute_empty sut
  end

  def test_add_label_adds_label
    sut = Sunstone::Objects::KubernetesObjectMetadata.new

    sut.add_label test: :value

    assert_equal :value, sut.labels[:test]
  end

  def test_add_labels_adds_labels
    sut = Sunstone::Objects::KubernetesObjectMetadata.new

    sut.add_label test1: :value1, test2: :value2

    assert_equal :value1, sut.labels[:test1]
    assert_equal :value2, sut.labels[:test2]
  end

  def test_add_annotation_adds_annotation
    sut = Sunstone::Objects::KubernetesObjectMetadata.new

    sut.add_annotation test: :value

    assert_equal :value, sut.annotations[:test]
  end

  def test_add_annotations_adds_annotations
    sut = Sunstone::Objects::KubernetesObjectMetadata.new

    sut.add_annotations test1: :value1, test2: :value2

    assert_equal :value1, sut.annotations[:test1]
    assert_equal :value2, sut.annotations[:test2]
  end

  def test_add_finalizer_adds_finalizer
    sut = Sunstone::Objects::KubernetesObjectMetadata.new

    sut.add_finalizer :test

    assert_equal 1, sut.finalizers.length
    assert_equal :test, sut.finalizers.first
  end

  def test_serialization
    sut = Sunstone::Objects::KubernetesObjectMetadata.new :test

    sut.add_label label: :label_value
    sut.add_annotation annotation: :annotation_value
    sut.add_finalizer :finalizer

    expected = {
      name: 'test',
      labels: { label: 'label_value' },
      annotations: { annotation: 'annotation_value' },
      finalizers: %w[finalizer]
    }

    assert_equal expected, sut.to_hash
  end
end
