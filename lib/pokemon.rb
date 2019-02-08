require 'sqlite3'
require 'pry'

# db = SQLite3::Database.new('pokemon.db')
# db.results_as_hash = true

class Pokemon
  attr_reader :name, :type, :id, :db, :hp

  def initialize(id: nil, name:, type:, hp:60,  db:)
    @name = name
    @type = type
    @db = db
    @hp = hp
    @id = id
  end

  def self.save(name,type,db)
    sql = <<-SQL
      INSERT INTO pokemon(name, type) VALUES (?,?);
    SQL
    db.execute(sql, name, type)
  end

  def self.parse_pokemon(pokemon_hash, db)
    Pokemon.new(id: pokemon_hash[0], name: pokemon_hash[1],type: pokemon_hash[2], hp: pokemon_hash[3], db: db)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id=?
      LIMIT 1;
    SQL
    pokemon_hash = db.execute(sql,id).first
    parse_pokemon(pokemon_hash, db)
  end

  def alter_hp(hp, db)
   @hp = hp
   db.execute("UPDATE pokemon SET hp =? WHERE id =?", @hp, @id)
 end

end
