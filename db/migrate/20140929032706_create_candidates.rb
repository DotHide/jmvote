class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :no
      t.string :name

      t.timestamps
    end
  end
end
