class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.references :element, foreign_key: true, null: false
      t.string :value, null: false
      t.timestamps
    end
  end
end
