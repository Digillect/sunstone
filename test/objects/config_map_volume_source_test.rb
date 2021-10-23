class ConfigMapVolumeSourceTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::ConfigMapVolumeSource.new(:test)
  end

  def test_initialization
    assert_equal :test, sut.name
    assert_empty sut.items
    assert_nil sut.default_mode
    assert_nil sut.optional
  end

  def test_items_is_readonly
    assert_raises do
      sut.items = []
    end
  end

  def test_add_item
    sut.add_item :appsettings, '/etc/config/appsettings.json'

    refute_empty sut.items

    item = sut.items.first

    assert_equal :appsettings, item.key
    assert_equal '/etc/config/appsettings.json', item.path
    assert_nil item.mode
  end

  def test_serialization
    sut.add_item :appsettings, '/etc/config/appsettings.json'

    sut.default_mode = 'mode'
    sut.optional = true

    expected = {
      name: 'test',
      items: [
        { key: 'appsettings', path: '/etc/config/appsettings.json' }
      ],
      defaultMode: 'mode',
      optional: true
    }

    assert_equal(expected.to_a, sut.to_hash.to_a)
  end
end
