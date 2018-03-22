class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.references :user, foreign_key: true
      t.string :subject_class
      t.string :subject_id
      t.string :action

      t.timestamps null: false
    end
  end
end
