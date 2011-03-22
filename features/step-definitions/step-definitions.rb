Before do
  file_name = File.expand_path((File.dirname(__FILE__) + '/../../db/hashmodel.dat'))
  File.delete(file_name) if File.exists?(file_name)
  Widget::Data.reset_instance
  @data = Widget::Data.instance
  @aruba_timeout_seconds = 30
end

Given /^I have a widget named "([^"]*)"$/ do |name|
  @data.create(name)
end

Given /^There are no widgets$/ do
  @data.delete_all
end

Given /^I have (\d+) widgets named "([^"]*)"$/ do |count, name|
  (1..count.to_i).each{|n| @data.create(name.gsub("\#{n}", n.to_s))}
end

Then /^the output should contain (\d+) lines matching "([^"]*)"$/ do |count, line|
  (1..count.to_i).each{|n| all_output.should =~ Regexp.new(line.gsub("\#{n}", n.to_s))}
end