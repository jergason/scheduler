require "spec_helper"

describe "Scheduler::Queue" do
  describe "initialization" do
    it "should load an existing yaml file correctly into the queue" do
      @queue = Scheduler::Queue.new("spec/queue.yaml")
      @queue.count.should == 5
    end

    it "should handle an empty yaml file correctly" do
      @queue = Scheduler::Queue.new("spec/empty.yaml")
      @queue.count.should == 0
    end

    it "should handle a non-existent file correctly" do
      File.exists?("spec/non_existing_file.yaml").should be_false
      @queue = Scheduler::Queue.new("spec/non_existing_file.yaml")
      @queue.respond_to?(:<<).should be_true
      @queue.count.should == 0
    end

    after do
      File.delete "spec/non_existing_file.yaml"  if File.exists? "spec/non_existing_file.yaml" 
      File.truncate "spec/empty.yaml", 0
    end
  end

  describe "saving" do
  end

  describe "other methods" do
    before do
      @queue = Scheduler::Queue.new("test.yaml")
    end

    describe "each_with_index" do
      it "should respond to each_with_index" do
        @queue.respond_to?(:each_with_index).should be_true
      end

      it "should correctly return an item and an index" do
      end
    end

    describe "<<" do
      it "should append something on to the queue" do
        lambda do
          @queue << { :beans => "bar", :foo => "foz" }
        end.should change(@queue, :count).by(1)
      end
    end
  end
end
