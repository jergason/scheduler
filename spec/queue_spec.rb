require "spec_helper"

describe "Scheduler::Queue" do
  describe "initialization" do
    it "should load an existing yaml file correctly into the queue" do

    end

    it "should handle an empty yaml file correctly" do
    end

    it "should handle a non-existent file correctly" do
    end
  end

  describe "saving" do
  end

  describe "each_with_index" do
    before do
      @queue = Scheduler::Queue.new("test.yaml")
    end

    it "should respond to each_with_index" do
      @queue.respond_to?(:each_with_index).should be_true
    end

    it "should correctly return an item and an index" do
    end
  end
end
