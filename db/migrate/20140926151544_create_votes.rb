class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :round
      t.integer :candidate_id
      t.string :class_name

      t.timestamps
    end
  end
end
