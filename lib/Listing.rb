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
    [
      "Lovely house",
      "Romantic get-away",
      "Seaside cottage",
      "Pandemic and chill"
     ]

    if ENV['ENVIRONMENT'] == 'test'
    connection = PG.connect(dbname: 'makersbnb_test')
  else
    connection = PG.connect(dbname: 'makersbnb')
  end
  result = connection.exec("SELECT * FROM listings")
  result.map do |listing|
    Listing.new(id: listing['id'], user_id: listing['user_id'], name: listing['name'], description: listing['description'],
      price: listing['price'], date_created: listing['date_created'], dates_available: ['dates_available'])
  end
  end




end
