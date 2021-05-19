class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.string :value, null: false
      t.timestamps
    end
  end
end
