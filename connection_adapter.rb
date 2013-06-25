require 'forwardable'

class ConnectionAdapter
  def find(table_name, id)
    rows = @db.execute "SELECT * FROM #{table_name} WHERE id = #{id} LIMIT 1;"
    zip_column_names(column_names(table_name), rows.first)
  end

  def find_all(table_name)
    rows = @db.execute "SELECT * FROM #{table_name};"

    columns = column_names(table_name)
    rows.map { |row| zip_column_names(columns, row) }
  end

  def zip_column_names(columns, values)
    Hash[columns.zip(values)]
  end
end


class SQLiteAdapter < ConnectionAdapter
  extend Forwardable

  def_delegators :@db, :execute, :table_info

  def initialize
    require 'sqlite3'
    @db = SQLite3::Database.new(File.dirname(__FILE__) + '/db/app.db')
  end

  def column_names(table_name)
    @db.table_info(table_name).map { |info| info['name'] }
  end
end

class MySQLAdapter < ConnectionAdapter
end
