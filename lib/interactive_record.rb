require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    sql = "PRAGMA table_info('#{table_name}')"
    array = DB[:conn].execute(sql)
    column_names = []
    array.each do |item|
      column_names << item["name"]
    end
    column_names.compact
  end

  self.column_names.each do |col_name|
      attr_accessor col_name.to_sym
    end

  def initialize(options = {})
    options.each do |key, value| self.send("#{key}=", value)
    end
  end

end
