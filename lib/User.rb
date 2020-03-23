require 'pg'

class User
attr_reader :id, :email, :name, :username, :password

  def self.create(email:, name:, username:, password: )
    if ENV['ENVIRONMENT'] == 'test'
      connect = PG.connect(dbname: "makersbnb_test")
    else
      connect = PG.connect(dbname: "makersbnb")
    end
    result = connect.exec("INSERT INTO users(email, name, username, password) VALUES ('#{email}', '#{name}', '#{username}', '#{password}') RETURNING id, email, name, username, password;")
    User.new(id: result[0]['id'], email: result[0]['email'],name: result[0]['name'], username: result[0]['username'], password: result[0]['password'])
  end

  def initialize(id:, email:, name:, username:, password:)
    @id = id
    @email = email
    @name = name
    @username = username
    @password = password

  end

end
