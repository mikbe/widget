require 'hashmodel'

# puts hm
# data = Marshal.dump(hm)
#File.new("dummy.hashmodel", "r")

hashmodel_file = "widget.hashmodel"

hm = HashModel.new
hm.add(:name=>"Phish")

File.open(hashmodel_file, "w"){|file| file.write(Marshal.dump(HashModel.new))} unless File.exist?(hashmodel_file)

hmo = Marshal.load(File.open(hashmodel_file, "r"))

puts hmo.class
puts hmo

# hm.add(:name=>"Widgee 5")
# put hm