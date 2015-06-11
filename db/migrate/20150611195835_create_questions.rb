class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :survey, index: true, foreign_key: true
      t.integer :order
      t.string :question_type
      t.string :value

      t.timestamps null: false
    end
  end
end
