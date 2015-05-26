class CreateShovels < ActiveRecord::Migration
  def change
    create_table :shovels do |t|
      t.string :name
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
