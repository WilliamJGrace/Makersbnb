require 'pg'
require_relative 'database_connection'


class Listing
attr_reader :id, :user_id, :name, :description, :price, :date_created, :dates_available, :img_url

  def initialize(id:, user_id:, name:, description:, price:, date_created:, dates_available:, img_url:)
    @id = id
    @user_id = user_id
    @name = name
    @description = description
    @price = price
    @date_created = date_created
    @dates_available = dates_available
    @img_url = img_url
  end

  def self.all

    result = DatabaseConnection.query("SELECT * FROM listings")

    result.map do |listing|

      Listing.new(id: listing['id'], user_id: listing['user_id'], name: listing['name'], description: listing['description'],
        price: listing['price'], date_created: listing['date_created'], dates_available: listing['dates_available'], img_url: listing['img_url'])
    end
  end

    # Peter's testing
  def self.create(user_id:, name:, description:, price:, dates_available:, img_url:)

    result = DatabaseConnection.query("INSERT INTO listings(user_id, name, description, price, date_created, dates_available, img_url) VALUES ('#{user_id}', '#{name}', '#{description}', '#{price}', '#{Time.now}', '#{dates_available}', '#{img_url}') RETURNING id, user_id, name, description, price, date_created, dates_available, img_url;")
    Listing.new(id: result[0]['id'], user_id: result[0]['user_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], date_created: result[0]['date_created'], dates_available: result[0]['dates_available'], img_url: result[0]['img_url'])
  end

  def self.update(id:, name:, description:, price:, dates_available:, img_url:)

    result = DatabaseConnection.query("UPDATE listings SET name = '#{name}', description = '#{description}', price = '#{price}', dates_available = '#{dates_available}', img_url = '#{img_url}' WHERE id = '#{id}' RETURNING id, user_id, name, description, price, date_created, dates_available, img_url;")
    Listing.new(id: result[0]['id'], user_id: result[0]['user_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], date_created: result[0]['date_created'], dates_available: result[0]['dates_available'], img_url: result[0]['img_url'])
  end

  def self.find(list_id)

   result = DatabaseConnection.query("SELECT * FROM listings WHERE id = '#{list_id}';")
   Listing.new(id: result[0]['id'], user_id: result[0]['user_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], date_created: result[0]['date_created'], dates_available: result[0]['dates_available'], img_url: result[0]['img_url'])
  end

  def self.delete(id:)

    DatabaseConnection.query("DELETE FROM requests WHERE listing_id ='#{id}'; ")
    DatabaseConnection.query("DELETE FROM listings WHERE id ='#{id}'; ")

  end
end
