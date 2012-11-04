module Developer
  def self.restore_production_schema
    delete_all_tables
    `rails dbconsole < db/production_structure.sql`
  end

  def self.drop_all_tables
    raise "Deleting all tables in #{Rails.env} is unsafe, are you crazy ?!" if Rails.env.production?
    ActiveRecord::Base.connection.execute("DROP TABLE #{table_names.join(',')}") if table_names.any?
  end

  def self.table_names
    sql = "SELECT * FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'"
    ActiveRecord::Base.connection.execute(sql).map { |row| row['table_name'] }
  end
end
