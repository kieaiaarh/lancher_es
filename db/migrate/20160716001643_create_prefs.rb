class CreatePrefs < ActiveRecord::Migration[5.0]
  def change
    create_table :prefs do |t|
      t.string :name

      t.timestamps
    end
  end
end
