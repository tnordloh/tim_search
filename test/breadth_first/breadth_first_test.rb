
require 'minitest/autorun'

require_relative '../../lib/tim_search/breadth_first'
require_relative 'cubicle'
describe TimSearch::BreadthFirst do
  def setup
    @cubicle = Cubicle.new(1350,[1,1])
  end

  it "can find a specific node, and the ancestor count to that node" do
    TimSearch::BreadthFirst.new(@cubicle)
      .find([39,31]).ancestors.size.must_equal(93)
  end

  it "can find a specific node, and the ancestor count to that node" do
    TimSearch::BreadthFirst.new(@cubicle)
      .children_within(50).must_equal(124)
  end

  it "notices that it has no 'ancestors' method" do
    -> { TimSearch::BreadthFirst.new(Object.new) }.must_raise(NoMethodError)
  end

end
