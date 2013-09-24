require 'minitest/autorun'
require_relative '../diff'


class TestDiff < MiniTest::Unit::TestCase

  def test_same_inputs
    original = [1,2]
    revised = [1,2]
    v = Versions.new(original, revised)
    assert_equal(v.diff, [1,2])
  end

  def test_just_additions
    original = [1,2]
    revised = [1, 3, 2, 4]
    v = Versions.new(original, revised)
    assert_equal(v.diff, [1, Display.added(3), 2, Display.added(4)])
  end

  def test_just_deletions
    original = [1, 3, 2, 4]
    revised = [1,2]
    v = Versions.new(original, revised)
    assert_equal(v.diff, [1, Display.deleted(3), 2, Display.deleted(4)])
  end

  def test_add_and_delete
    original = [1, 3, 2]
    revised = [1, 2, 4]
    v = Versions.new(original, revised)
    assert_equal(v.diff, [1, Display.deleted(3), 2, Display.added(4)])
  end

end