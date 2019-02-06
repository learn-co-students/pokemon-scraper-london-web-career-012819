require "pry"
class Pokemon
  attr_reader :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, hp: 60, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def alter_hp(hp, db)
    @hp = hp
    db.execute("UPDATE pokemon SET hp =? WHERE id =?", @hp, @id)
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(num, db)
    array = db.execute("SELECT * FROM pokemon WHERE pokemon.id = #{num}").flatten
    Pokemon.new(id: num, name: array[1], type: array[2], hp: array[3], db: db)
  end
end
