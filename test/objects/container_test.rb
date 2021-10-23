class ContainerTest < Minitest::Test
  attr_reader :sut

  def setup
    @sut = Sunstone::Objects::Container.new(:main)
  end

  def test_args_as_a_command
    sut.args 'a', 'b', 'c'

    assert_equal %w[a b c], sut.args
  end

  def test_commands_as_a_command
    sut.command 'a', 'b', 'c'

    assert_equal %w[a b c], sut.command
  end

  def test_serialization
    sut.image 'test/test'
    sut.image_pull_policy :Always

    expected = {
      name: 'main',
      image: 'test/test',
      imagePullPolicy: 'Always'
    }

    assert_equal expected.to_a, sut.to_hash.to_a
  end
end
