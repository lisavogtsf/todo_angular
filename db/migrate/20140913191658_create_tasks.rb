class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :desc
      t.datetime :due

      t.timestamps
    end
  end
end
