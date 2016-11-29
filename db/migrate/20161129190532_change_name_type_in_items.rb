class ChangeNameTypeInItems < ActiveRecord::Migration[5.0]
  def change
    enable_extension("citext")

    change_column :items, :name, :citext
  end
end
