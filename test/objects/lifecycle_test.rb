class LifecycleTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Lifecycle.new
  end

  def test_empty_on_fresh_instance
    assert_empty sut
  end

  def test_empty_with_post_start_set
    sut.post_start do
      use_command 'ls'
    end

    refute_empty sut
  end

  def test_empty_with_pre_stop_set
    sut.pre_stop do
      use_command 'ls'
    end

    refute_empty sut
  end

  def test_serialization
    sut.post_start.use_command 'ls'
    sut.pre_stop.use_tcp 5432

    expected = {
      postStart: {
        exec: {
          command: %w[ls]
        }
      },
      preStop: {
        tcpSocket: {
          port: 5432
        }
      }
    }

    assert_equal expected, sut.to_hash
  end
end
