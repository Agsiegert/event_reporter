require 'minitest'
require 'minitest/autorun'
require './queue'

class QueueTest < MiniTest::Test

  def test_queue_exists
    q = Queue.new
    assert_kind_of Queue,q
  end

  # def test_queue_clear_empties_queue
  #   qc = Queue.new
  #   qc.queue_clear
  #   assert_equal nil , qc.results
  # end

  # def test_load_loads_filename_csv
  # end

  # def test_help_shows_command_or_help_list
  # end

end