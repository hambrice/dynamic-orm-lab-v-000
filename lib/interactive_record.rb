require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'
class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    sql = "PRAGMA table_info('#{self.table_name}')"
    array = DB[:conn].execute(sql)
    column_names = []
    array.each do |item|
      #if item["name"] != "id"
        column_names << item["name"]
      #end
    end
    column_names.compact
  end

  def initialize(options = {})
    #binding.pry
    options.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    self.class.column_names.delete_if {|col| col == "id"}.join(", ")

  end

  def values_for_insert
    values = []
    self.class.column_names.each do |column|
      values << "'#{send(column)}'" unless send(column).nil?
    end
  end

end
