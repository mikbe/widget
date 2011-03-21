module Widget
  class Viewtroller
    extend Commandable

    # You shouldn't try to call initialize using Commandable because it creates a new
    # class automatically for instance methods.
    # 
    # Think of the classes you let Commandable control as entry points to your app.
    # Don't try to have Commandable do a lot of class creation and manipulation of
    # your application, just have the methods you call do all that.
    def initialize
      @data = Data.instance
    end

    command "create a new widget"
    # The method name "new" makes sense here but notice it's not the class.new method
    def new(name)
      if @data.create(name)
        "You created widget #{name}"
      else
        "#{name} already exists!"
      end
    end
    command "add a new widget"
    alias :add :new

    command "show a widget's details, if no name is given shows all widgets"
    def show(name=nil)
      if name 
        widgets = @data.read(name)
        return "There is no #{name} in storage." if widgets.empty?
      else
        widgets = @data.read_all
        return "There are no widgets in storage." if widgets.empty?
      end
      print_widgets(widgets)
    end

    def print_widgets(widgets)
      widgets.collect{|widget| " #{widget[:name]}: created: #{widget[:created_at]}; modified: #{widget[:modified_at]};"}
    end

    command "delete all widgets from storage", :priority=>10
    def reset
      @data.delete_all
      "All widgets destroyed. May they rest in peace."
    end

    command "return a list of existing widget names", :default
    def list
      puts "Widgets:"
      if @data.length > 0
        @data.read_all.collect{|widget| " #{widget[:name]}"}
      else
        " <none>"
      end
    end

    command "destroy an existing widget", :xor
    def destroy(name)
      if @data.delete(name)
        "#{name} destroyed. You heartless bastard!"
      else
        "There is no #{name} in storage."
      end
    end
    command "delete an existing widget", :xor
    alias :delete :destroy 
    
    command "spend lots of money to update a widget", :xor
    def upgrade(name)
      if @data.update(name) 
        "You just gave #{name} a fresh coat of paint!"
      else
        "There is no #{name} in storage."
      end
    end

  end
end