require 'pg'
require 'bcrypt'
require_relative 'database_connection'

class User
attr_reader :id, :email, :name, :username, :password

  def self.create(email:, name:, username:, password: )

    if ENV['ENVIRONMENT'] == "test"
      connect = PG.connect(dbname: "makersbnb_test")
    else
      connect = PG.connect(dbname: "makersbnb")
    end
    check = connect.exec("SELECT * FROM users WHERE username = '#{username}';")
    return if check.any?
    encrypted_password = BCrypt::Password.create(password)
    result = connect.exec("INSERT INTO users(email, name, username, password) VALUES ('#{email}', '#{name}', '#{username}', '#{encrypted_password}') RETURNING id, email, name, username, password;")
    User.new(id: result[0]['id'], email: result[0]['email'],name: result[0]['name'], username: result[0]['username'], password: result[0]['password'])
  end

  def initialize(id:, email:, name:, username:, password:)
    @id = id
    @email = email
    @name = name
    @username = username
    @password = password

  end

  def self.find(id)

    result = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}';")
    User.new(id: result[0]['id'], email: result[0]['email'],name: result[0]['name'], username: result[0]['username'], password: result[0]['password'])
  end

  def self.authenticate(username:, password:)

    result = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}';")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password

    User.new(id: result[0]['id'], email: result[0]['email'], name: result[0]['name'], username: result[0]['username'], password: result[0]['password'])
  end
end
