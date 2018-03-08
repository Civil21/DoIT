class CreateCategorings < ActiveRecord::Migration[5.1]
  def change
    create_table :categorings do |t|
      t.belongs_to :question, foreign_key: true
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
