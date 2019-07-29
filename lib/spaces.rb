require 'pg'
require_relative 'database_connection'
require_relative '../spec/database_connection_setup.rb'

class Spaces

  attr_reader :address, :title, :description, :price_per_night, :owner

  def initialize(address:, title:, description:, price_per_night:, owner: )
    @address = address
    @title = title
    @description = description
    @price_per_night = price_per_night
    @owner = owner
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    result.map { |space| Spaces.new(address: space['address'],
                description: space['description'],
                price_per_night: 'price_per_night', 
                title: space['title'], owner: space['owner'])}
  end
end
