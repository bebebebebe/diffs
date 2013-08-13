require 'minitest/autorun'
require_relative '../diff.rb'

class TestUnjumble < MiniTest::Unit::TestCase

  def test_all_red
    word = [Display.deleted('a'),Display.deleted('b'),Display.deleted('c')]
    assert_equal(unjumble(word), word)
  end

  def test_black_and_green
    word = ['a', Display.added('b'), Display.added('c')]
    assert_equal(unjumble(word), word)
  end

  def test_three_colours
    word = ['a', Display.added('b'), 'c', Display.deleted('d'), Display.added('e')]
    assert_equal(unjumble(word), [Display.deleted('a'), Display.deleted('c'), 
      Display.deleted('d'), Display.added('a'), Display.added('b'), Display.added('c')])
  end

end