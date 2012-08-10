# -*- encoding : utf-8 -*-
# From http://snipplr.com/view/873/foreignkeymigrationrb/

module ForeignKey
  # Add foreign-key constraints when creating tables. It uses SQL-92 syntax and as such should be
  # compatible with most databases that support foreign-key constraints. By default, 
  # the constraint is named "fk_table_a_on_table_b
  # 
  # ===== Examples
  # Add a foreign key to movie_crews (person_id) that references people table (id)
  #   add_foreign_key :movie_crews, :person_id, :people
  # 
  # Specify the referenced columns
  #   add_foreign_key :movie_crews, :person_id, :people, :id
  # 
  # Multiple columns
  #   add_foreign_key :movie_crews, [:person_id, :role], :people, [:id, :role]
  # 
  # Add a foreign key with a name
  #   add_foreign_key :movie_crews, :person_id, :people, :id, :name => 'movie_crews_xref_people'
  # 
  def add_foreign_key(foreign_table_name, foreign_column_names, primary_table_name, primary_column_names = :id, options = {})
    return if ActiveRecord::Base.connection.adapter_name == 'MySQL'
    foreign_column_names = Array(foreign_column_names).join(", ")
    primary_column_names = Array(primary_column_names).join(", ")
    fk_name = options[:name] || fk_name(foreign_table_name, foreign_column_names, primary_table_name, primary_column_names)
    execute "ALTER TABLE #{foreign_table_name} ADD CONSTRAINT #{fk_name} FOREIGN KEY (#{foreign_column_names}) REFERENCES #{primary_table_name} (#{primary_column_names})"
  end

  # Remove a foreign key constraint
  # 
  # ==== Examples
  # ===== Remove the fk 'fk_user_role_user' from 'users_roles' table
  #   remove_foreign_key :users_roles, :fk_users_roles_user
  #   
  # ===== Remove the fk on comments (post_id) reference posts (id)
  #   remove_foreign_key :comments, :post_id, :posts
  #   
  def remove_foreign_key(foreign_table_name, fk_name, primary_table_name = nil, primary_column_names = nil)
    return if ActiveRecord::Base.connection.adapter_name == 'MySQL'
    primary_column_names = :id unless primary_column_names
    fk_name = fk_name(foreign_table_name, fk_name, primary_table_name, primary_column_names) if primary_table_name
    execute "ALTER TABLE #{foreign_table_name.to_s} DROP CONSTRAINT #{fk_name.to_s}"
  end

  def fk_name(foreign_table_name, foreign_column_names, primary_table_name, primary_column_names)
    "fk_#{foreign_table_name.to_s}_on_#{primary_table_name.to_s}"
  end
end