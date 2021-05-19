class CreateElements < ActiveRecord::Migration[6.1]
  def change
    create_table :elements do |t|
      t.timestamps
    end
  end
end
