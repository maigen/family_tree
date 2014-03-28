class EditPerson < ActiveRecord::Migration
  def change
    add_column :people, :child_id, :int
    add_column :people, :parent_id_1, :int
    add_column :people, :parent_id_2, :int
  end
end
