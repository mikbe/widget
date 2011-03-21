require 'spec_helper'
require 'time'

describe Widget::Data do

  before(:each) {
    file_name = File.expand_path((File.dirname(__FILE__) + '/../../db/hashmodel.dat'))
    File.delete(file_name) if File.exists?(file_name)
    @data = Widget::Data.instance
    Widget::Data.reset_instance
  }
  
  context "when creating a widget" do
    
    context "and there isn't a widget with that name" do
      it {lambda{@data.create("Widgee 5"); @data.reload}.should change{@data.count}.by(1)}
      it { @data.create("Widgee 5").should be_true }

      context "but there is another widget" do
        before(:each){@data.create("Widgee 1"); @data.reload }
        it {@data.create("Widgee 5").should be_true }
        it {@data.create("Widgee 5"); @data.reload; @data.length.should == 2 }
      end
    end
    
    context "and there is already a widget with that name" do
      before(:each){@data.create("Widgee 5")}
      it "doesn't add a widget" do
        lambda{@data.create("Widgee 5"); @data.reload}.should_not change{@data.length}
      end
    end
    
  end

  context "when reading widgets" do
    
    it "should read by name" do
      widgee_whatever = "Widgee #{rand(100)}"
      @data.create(widgee_whatever)
      @data.reload
      @data.read(widgee_whatever).to_s.should match(/#{widgee_whatever}/)
    end
    
    it "should read_all widgets" do
      4.times { |i| @data.create("Widgee #{i}")}
      @data.reload
      4.times { |i| @data.read_all.to_s.should match("Widgee #{i}")}
    end
    
  end

  context "when deleteing widgets" do
    before(:each) do
      10.times { |i| @data.create("Widgee #{i}") }
      @data.reload
    end

    context "and you clear them all" do
      it{@data.delete_all; @data.reload; @data.length.should == 0}
    end

    context 'and you delete one by name' do
      let(:widgee){"Widgee 0"}
      it {lambda{@data.delete(widgee); @data.reload}.should change{@data.length}.from(10).to(9)}
      it {@data.delete(widgee); ;@data.reload; @data.read(widgee).should be_empty}
    end
    
  end
  
  context "when upgrading a widget" do
    before(:each) do
      3.times { |i| @data.create("Widgee #{i}"); @data.reload }
    end

    context "and the widget exists" do
      it {lambda{@data.update("Widgee 1")}.should_not raise_error}
      it {lambda{@data.update("Widgee 1"); @data.reload}.should change{@data.read("Widgee 1")[0][:modified_at].clone}}
      it {@data.update("Widgee 1").should be_true}
    end
    
    context "but the widget doesn't exist" do
      it {lambda{@data.update("Widgee 99")}.should_not raise_error}
      it {@data.update("Widgee 99").should be_false}
    end
    
  end

end