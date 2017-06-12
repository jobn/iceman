class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :plan, foreign_key: true
      t.string :title
      t.string :color
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end

    add_index :events, :starts_at
  end
end
