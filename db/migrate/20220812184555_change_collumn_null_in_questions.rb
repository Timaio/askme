class ChangeCollumnNullInQuestions < ActiveRecord::Migration[7.0]
  def change
    change_column_null :questions, :hidden, false
  end
end
