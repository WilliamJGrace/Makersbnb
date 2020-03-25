require 'pg'
class Listing
attr_reader :id, :user_id, :name, :description, :price, :date_created, :dates_available

def initialize(id:, user_id:, name:, description:, price:, date_created:, dates_available:)
  @id = id
  @user_id = user_id
  @name = name
  @description = description
  @price = price
  @date_created = date_created
  @dates_available = dates_available
end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec("SELECT * FROM listings")

    result.map do |listing|

      Listing.new(id: listing['id'], user_id: listing['user_id'], name: listing['name'], description: listing['description'],
        price: listing['price'], date_created: listing['date_created'], dates_available: listing['dates_available'])
    end
  end

    # Peter's testing
  def self.create(user_id:, name:, description:, price:, dates_available:)
    if ENV['ENVIRONMENT'] == 'test'
      connect = PG.connect(dbname: "makersbnb_test")
    else
      connect = PG.connect(dbname: "makersbnb")
    end
    result = connect.exec("INSERT INTO listings(user_id, name, description, price, date_created, dates_available) VALUES ('#{user_id}', '#{name}', '#{description}', '#{price}', '#{Time.now}', '#{dates_available}') RETURNING id, user_id, name, description, price, date_created, dates_available;")
    Listing.new(id: result[0]['id'], user_id: result[0]['user_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], date_created: result[0]['date_created'], dates_available: result[0]['dates_available'])
  end

  def self.update(id:, name:, description:, price:, dates_available:)
    if ENV['ENVIRONMENT'] == 'test'
       connect = PG.connect(dbname: "makersbnb_test")
    else
      connect = PG.connect(dbname: "makersbnb")
    end
    result = connect.exec("UPDATE listings SET name = '#{name}', description = '#{description}', price = '#{price}', dates_available = '#{dates_available}' WHERE id = '#{id}' RETURNING id, user_id, name, description, price, date_created, dates_available;")
    Listing.new(id: result[0]['id'], user_id: result[0]['user_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], date_created: result[0]['date_created'], dates_available: result[0]['dates_available'])
  end
  
  def self.find(list_id)
   if ENV['ENVIRONMENT'] == 'test'
       connect = PG.connect(dbname: "makersbnb_test")
   else
      connect = PG.connect(dbname: "makersbnb")
   end     
   result = connect.exec("SELECT * FROM listings WHERE id = '#{list_id}';")
   Listing.new(id: result[0]['id'], user_id: result[0]['user_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], date_created: result[0]['date_created'], dates_available: result[0]['dates_available'])
  end

end
