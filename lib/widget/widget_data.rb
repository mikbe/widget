require 'hashmodel'
require 'singleton'
require 'time'

module Widget
  class Data
    include Singleton
        
    def initialize(clean_slate=false)
      hm = HashModel.new
      save_widget(HashModel.new) unless File.exist?(HASHMODEL_FILE) || clean_slate
      @widgets = load_widget
    end
    
    def length
      @widgets.length
    end
    alias :count :length
    
    # CRUD
    
    def create(name)
      return false unless @widgets.where(name).empty?
      save_now = now
      @widgets.add(:name=>name, :created_at=>save_now, :modified_at=>save_now)
      save_widget
      true
    end
  
    def read(name)
      @widgets.where(name)
    end

    def update(name)
      !@widgets.update(name, :modified_at=>now).empty?
    end
    
    def delete(name)
      return false if @widgets.where(name).empty?
      @widgets.delete!(name)
      true
    end

    # CRUD helpers
    
    def delete_all
      @widgets.clear
    end
    
    def read_all
      @widgets.clone
    end
    
    private

    HASHMODEL_FILE = File.expand_path((File.dirname(__FILE__) + '/../../db/hashmodel.dat'))
    
    def load_widget
       Marshal.load(File.open(HASHMODEL_FILE, "r"))
    end

    def save_widget(widget=@widgets)
      File.open(HASHMODEL_FILE, "w"){|file| file.write(Marshal.dump(widget))}
    end

    def now
      Time.now.xmlschema(2)
    end

  end

end