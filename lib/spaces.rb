require 'pg'
require_relative 'database_connection'
require_relative '../spec/database_connection_setup.rb'

class Spaces

  attr_reader :space_id, :address, :title, :description, :price_per_night, :owner

  def initialize(space_id:, address:, title:, description:, price_per_night:, owner:)
    @address = address
    @title = title
    @description = description
    @price_per_night = price_per_night
    @space_id = space_id
    @owner = owner
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    result.map { |space| Spaces.new(address: space['address'],
                description: space['description'],
                price_per_night: 'price_per_night', 
                title: space['title'], owner: space['owner'], space_id: space['space_id'])}
  end

  def self.add(address, title, description, price_per_night, user_id)
    result = DatabaseConnection.query(
      "INSERT INTO spaces (address, title, description, price_per_night, owner)
       VALUES ('#{address}', '#{title}', '#{description}', '#{price_per_night}', '#{user_id}')
       RETURNING space_id, address, title, description, price_per_night;"
    )
    Spaces.new(space_id: result[0]['space_id'], address: result[0]['address'], title: result[0]['title'], 
              description: result[0]['description'], price_per_night: result[0]['price_per_night'], owner: user_id)
  end
end
