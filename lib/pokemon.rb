class Pokemon

  attr_reader :id, :name, :type, :db, :hp

  def initialize (id:, name:, type:, hp: 60, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def alter_hp(hp, db)
    @hp = hp
    db.execute("UPDATE pokemon SET hp =? WHERE id =?", @hp, @id)
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, db)
    data = db.execute("SELECT * FROM pokemon WHERE id = #{id}").flatten
    Pokemon.new(id: data[0], name: data[1], type: data[2], hp: data[3], db: db)
  end
end
