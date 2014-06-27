require "sqlite3"

class IdGenerator
  def genIDs(number, length)

    resArr = Array.new
    db = SQLite3::Database.open('id.db')

    for i in 1..number
      id = ""
      for j in 1..length
        id = id + rand(10).to_s
      end

      res = db.execute("select id from ids where id = #{id}")
      if res.length != 0
        redo
      end
      res = db.execute("insert into ids values(#{id})")

      resArr.push(id)
    end

    return resArr
  end

  def getOtherIDs(path)
    resArr = Array.new
    db = SQLite3::Database.open('id.db')
    dbres = db.execute('select id from ids')

    dbres.each do |record|
      id = "%010d" % record[0]
      filename = id + '.jpg'
      if !File.exists?(path + filename)
        resArr.push(id)
      end
    end
    return resArr
  end
end