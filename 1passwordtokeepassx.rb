#!/usr/bin/ruby
=begin
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end

require "rexml/document"
include REXML
require 'csv'

def usage (message = nil)
  if message
    puts "ERROR: #{message}"
  end
  puts """Usage: 1pass2keepass.rb 1pass.csv

Takes a _TAB_ delimeted csv file from 1password and prints XML suitable for import into keepassX
"""
  exit
end


input_file = ARGV[0]
unless ARGV[0]
  usage
end
unless File.exists?(input_file)
  usage "File '#{input_file}' does not exist"
end

begin
  csv_data = CSV.read(input_file)
  #puts csv_data
  headers = csv_data.shift.map {|i| i.to_s }
  #puts headers
  string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
  #puts string_data
  array_of_hashes = string_data.map {|row| Hash[*headers.zip(row).flatten] }
  #puts array_of_hashes
rescue
  usage $!
end

doc = Document.new
database = doc.add_element 'database'
group = database.add_element 'group'
group.add_element('title').text = 'Internet'
group.add_element('icon').text = '1'


array_of_hashes.each do |row|
  entryNode = group.add_element 'entry'
  entryNode.add_element('username').text = row['Username']
  entryNode.add_element('password').text = row['Password']
  entryNode.add_element('title').text = row['Title']
  entryNode.add_element('url').text = row['URL']
  entryNode.add_element('comment').text = row['Notes']
end

doc << XMLDecl.new
doc.write($stdout)
