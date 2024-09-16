class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.string :knowledge_area

      t.timestamps
    end
  end
end
