


class Pokemon
  attr_accessor :name, :type, :hp
  attr_reader :id, :db

  def initialize (id:, name:, type:, db:)
    @name = name
    @type = type
    @id = id
    @db = db
  end

  def self.save (name, type, db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
    db.execute(sql, name, type)
  end

  def self.new_from_db(row, db)
    pok_id = row[0]
    pok_name = row[1]
    pok_type = row[2]
    pokemon = self.new(name: pok_name, type: pok_type, id: pok_id, db: db)
    pokemon.hp = row[3]
    pokemon
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    db.execute(sql, id).map do |row|
      self.new_from_db(row, db)
    end.first
  end

  def alter_hp (hp, db)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?
    SQL
    db.execute(sql, hp, self.id)
  end

end