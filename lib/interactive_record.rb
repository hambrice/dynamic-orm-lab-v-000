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
      column_names << item["name"]
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
    self.class.column_names
  end

  
end
