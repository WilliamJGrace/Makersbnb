require 'pg'
require './database_connection_setup'


class Requests
attr_reader :id, :listing_user_id, :requester_user_id, :listing_id, :name, :description, :price, :dates_booked, :isConfirmed
  def initialize(id:, listing_user_id:, requester_user_id:, listing_id:, name:, description:, price:, dates_booked:, isConfirmed:)
    @id = id
    @listing_user_id = listing_user_id
    @requester_user_id = requester_user_id
    @listing_id = listing_id
    @name = name
    @description = description
    @price = price
    @dates_booked = dates_booked
    @isConfirmed = isConfirmed
  end

  def self.all

    result = DatabaseConnection.query("SELECT * FROM requests")
    result.map do |request|
      Requests.new(id: request['id'], listing_user_id: request['listing_user_id'], requester_user_id: request['requester_user_id'], listing_id: request['listing_id'], name: request['name'], description: request['description'], price: request['price'], dates_booked: request['dates_booked'], isConfirmed: request['isconfirmed'])
    end
  end

  def self.create(listing_user_id:, requester_user_id:, listing_id:, name:, description:, price:, dates_booked:)

    result = DatabaseConnection.query("INSERT INTO requests(listing_user_id, requester_user_id, listing_id, name, description, price, dates_booked) VALUES ('#{listing_user_id}','#{requester_user_id}','#{listing_id}','#{name}','#{description}','#{price}','#{dates_booked}') RETURNING id, listing_user_id, requester_user_id, listing_id, name, description, price, dates_booked, isconfirmed;")
    Requests.new(id: result[0]['id'], listing_user_id: result[0]['listing_user_id'], requester_user_id: result[0]['requester_user_id'], listing_id: result[0]['listing_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], dates_booked: result[0]['dates_booked'], isConfirmed: result[0]['isconfirmed'])
  end

  def self.confirm_booking(id:)

    result = DatabaseConnection.query("UPDATE requests SET isconfirmed = TRUE WHERE id = '#{id}' RETURNING id, listing_user_id, requester_user_id, listing_id, name, description, price, dates_booked, isconfirmed;")
    Requests.new(id: result[0]['id'], listing_user_id: result[0]['listing_user_id'], requester_user_id: result[0]['requester_user_id'], listing_id: result[0]['listing_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], dates_booked: result[0]['dates_booked'], isConfirmed: result[0]['isconfirmed'])
  end

  def self.delete_request(id:)

    DatabaseConnection.query("DELETE FROM requests WHERE id ='#{id}'; ")
  end


end
