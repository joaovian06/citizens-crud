class CreateCitizens < ActiveRecord::Migration[7.0]
  def change
    create_table :citizens do |t|
      t.string :full_name
      t.string :cpf
      t.string :cns
      t.string :email
      t.date :birthdate
      t.string :phone_number
      t.string :avatar
      t.integer :status

      t.timestamps
    end
  end
end
