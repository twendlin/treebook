class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.string :Asset
      t.string :Age
      t.text :Description

      t.timestamps
    end
  end
end
