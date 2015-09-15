# encoding: UTF-8

require 'rubygems'
gem 'minitest'
require 'minitest/autorun'

require_relative 'preprocessor'

class TestPreprocessor < Minitest::Test
  def test_span_with_one_class
    line = Preprocessor::Line.new("hello [.wacky world]")

    assert_equal 'hello <span class="wacky">world</span>', line.processed
  end

  def test_span_with_multiple_class
    line = Preprocessor::Line.new("hello [.wacky.wibbly world]")

    assert_equal 'hello <span class="wacky wibbly">world</span>', line.processed
  end

  def test_citations
    line = Preprocessor::Line.new('["thunk"](^Bloopie, et. al. p. 792)')

    assert_equal '<span class="cited">"thunk" <span class="citation">Bloopie, et. al. p. 792</span></span>', line.processed
  end

  def test_spans_nested_in_citations
    line = Preprocessor::Line.new('[[.heavy "thunk"]](^Bloopie, et. al. p. 792)')

    assert_equal '<span class="cited"><span class="heavy">"thunk"</span> <span class="citation">Bloopie, et. al. p. 792</span></span>', line.processed
  end

  def test_that_it_leaves_markdown_links_alone
    line = Preprocessor::Line.new("grøtings, [Earth](http://en.wikipedia.org/wiki/Earth)")

    assert_equal 'grøtings, [Earth](http://en.wikipedia.org/wiki/Earth)', line.processed
  end

  def test_exercises
    line = Preprocessor::Line.new('[<exercise What? === That!>]')

    assert_equal '<span class="exercise-prompt">What?</span><input type="text" class="exercise-answer" data-answer="That!" size="5"/>', line.processed
  end
end
