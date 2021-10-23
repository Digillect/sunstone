class HandlerTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Handler.new
  end

  def test_empty_on_fresh_instance
    assert_empty sut
  end

  def test_empty
    sut.use_command 'ls'

    refute_empty sut
  end

  def test_serialization
    sut.use_command 'ls', '-al'

    expected = { exec: { command: %w[ls -al] } }

    assert_equal expected, sut.to_hash
  end
end
