require 'pg'

class Requests
attr_reader :id, :listing_user_id, :requester_user_id, :listing_id, :name, :description, :price, :dates_booked
  def initialize(id:, listing_user_id:, requester_user_id:, listing_id:, name:, description:, price:, dates_booked:)
    @id = id
    @listing_user_id = listing_user_id
    @requester_user_id = requester_user_id
    @listing_id = listing_id
    @name = name
    @description = description
    @price = price
    @dates_booked = dates_booked
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec("SELECT * FROM requests")

    result.map do |request|
      Requests.new(id: result[0]['id'], listing_user_id: result[0]['listing_user_id'], requester_user_id: result[0]['requester_user_id'], listing_id: result[0]['listing_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], dates_booked: result[0]['dates_booked'])
    end
  end

  def self.create(listing_user_id:, requester_user_id:, listing_id:, name:, description:, price:, dates_booked:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec("INSERT INTO requests(listing_user_id, requester_user_id, listing_id, name, description, price, dates_booked) VALUES ('#{listing_user_id}','#{requester_user_id}','#{listing_id}','#{name}','#{description}','#{price}','#{dates_booked}') RETURNING id, listing_user_id, requester_user_id, listing_id, name, description, price, dates_booked;")
    Requests.new(id: result[0]['id'], listing_user_id: result[0]['listing_user_id'], requester_user_id: result[0]['requester_user_id'], listing_id: result[0]['listing_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], dates_booked: result[0]['dates_booked'])
  end
end
