require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  test "search a note" do
    notes = Note.search("matz")
    assert_equal 1, notes.length
    assert_equal "Matz", notes[0].title
    assert_equal "I love Ruby !", notes[0].content
  end
end
