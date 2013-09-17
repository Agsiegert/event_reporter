require 'minitest'
require 'minitest/autorun'
require './queue'

class QueueTest < MiniTest::Test

  def test_queue_exists
    q = Queue.new
    assert_kind_of Queue, q
  
  end

  

end
