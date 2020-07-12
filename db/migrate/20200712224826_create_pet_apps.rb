class CreatePetApps < ActiveRecord::Migration[5.1]
  def change
    create_table :pet_apps do |t|
      t.references :pet, foreign_key: true
      t.references :app, foreign_key: true
    end
  end
end
