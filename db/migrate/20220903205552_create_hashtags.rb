class CreateHashtags < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtags do |t|
      t.string :text

      t.timestamps
    end

    create_table :hashtags_questions, id: false do |t|
      t.references :question, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true
    end
  end
end
