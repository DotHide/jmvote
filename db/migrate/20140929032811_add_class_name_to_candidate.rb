class AddClassNameToCandidate < ActiveRecord::Migration
  def self.up
  	add_column :candidates, :class_name, :string
  end

  def self.down
  	remove_column :candidates, :class_name
  end
end
