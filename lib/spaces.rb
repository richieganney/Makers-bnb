require 'database_connection'
class Spaces
  def initialize(id, address, title, description, price_per_night, user_id)
    @id = id
    @address = address
    @title = title
    @description = description
    @price_per_night = price_per_night
    @user_id = user_id
  end

  attr_reader :id, :address, :title, :description, :price_per_night, :user_id

  def self.add(address, title, description, price_per_night, user_id)
    result = DatabaseConnection.query(
      "INSERT INTO spaces (address, title, description, price_per_night, owner)
       VALUES ('#{address}', '#{title}', '#{description}', '#{price_per_night}', '#{user_id}')
       RETURNING space_id, address, title, description, price_per_night;"
    )
    Spaces.new(result[0]['space_id'],result[0]['address'],result[0]['title'],result[0]['description'],result[0]['price_per_night'], user_id)
  end
end
