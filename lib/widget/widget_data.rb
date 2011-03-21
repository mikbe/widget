require 'hashmodel'
require 'singleton'
require 'time'

module Widget
  class Data
    include Singleton
        
    def initialize(clean_slate=false)
      hm = HashModel.new
      save_widgets(HashModel.new) unless File.exist?(HASHMODEL_FILE) || clean_slate
      @widgets = load_widgets
    end
    
    def length
      @widgets.length
    end
    alias :count :length
    
    # CRUD
    
    def create(name)
      return false unless @widgets.where(name).empty?
      time_now = now
      @widgets.add(:name=>name, :created_at=>time_now, :modified_at=>time_now)
      save_widgets
      true
    end
  
    def read(name)
      @widgets.where(name)
    end

    def update(name)
      # note the destructive update! method
      changed = !(@widgets.update!(name, :modified_at=>now).empty?)
      save_widgets
      changed
    end
    
    def delete(name)
      return false if @widgets.where(name).empty?
      @widgets.delete!(name)
      save_widgets
      true
    end

    # CRUD helpers
    
    def delete_all
      @widgets.clear
      save_widgets
    end
    
    def read_all
      @widgets.clone
    end
    
    def reload
      load_widgets
    end
    
    private

    HASHMODEL_FILE = File.expand_path((File.dirname(__FILE__) + '/../../db/hashmodel.dat'))
    
    def load_widgets
       Marshal.load(File.open(HASHMODEL_FILE, "r"))
    end

    def save_widgets(widget=@widgets)
      File.open(HASHMODEL_FILE, "w"){|file| file.write(Marshal.dump(widget))}
    end

    def now
      Time.now.xmlschema(4)
    end

  end

end