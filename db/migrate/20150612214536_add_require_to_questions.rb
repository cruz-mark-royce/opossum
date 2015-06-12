class AddRequireToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :require, :boolean
  end
end
