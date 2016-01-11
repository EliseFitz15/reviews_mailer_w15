class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.string :name, null: false
      t.string :ability, null: false
      t.string :poketype, null: false
      t.integer :strength
      t.integer :age

      t.timestamp null: false
    end
  end
end
