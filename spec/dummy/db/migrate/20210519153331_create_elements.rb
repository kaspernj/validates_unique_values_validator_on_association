class CreateElements < ActiveRecord::Migration[6.1]
  def change
    create_table :elements, &:timestamps
  end
end
