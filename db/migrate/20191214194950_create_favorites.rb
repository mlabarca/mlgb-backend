class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.string :job_id
      t.string :email

      t.timestamps
    end

    add_index :favorites, :email
  end
end
