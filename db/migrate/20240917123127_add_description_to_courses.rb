class AddDescriptionToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :description, :text
  end
end
