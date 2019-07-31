require 'pg'
require_relative 'database_connection'
require_relative '../spec/database_connection_setup.rb'

class Spaces

  attr_reader :space_id, :address, :title, :description, :price_per_night, :owner, :available_from, :available_to

  def initialize(space_id:, address:, title:, description:, price_per_night:, owner:, available_from:, available_to:)
    @address = address
    @title = title
    @description = description
    @price_per_night = price_per_night
    @space_id = space_id
    @owner = owner
    @available_from = available_from
    @available_to = available_to
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    result.map { |space| Spaces.new(address: space['address'],
                description: space['description'],
                price_per_night: 'price_per_night',
                title: space['title'], owner: space['owner'], space_id: space['space_id'],
                available_from: space['available_from'], available_to: space['available_to'])}

  end

  def self.add(address, title, description, price_per_night, user_id, available_from, available_to)
    result = DatabaseConnection.query(
      "INSERT INTO spaces (address, title, description, price_per_night, owner, available_from, available_to)
       VALUES ('#{address}', '#{title}', '#{description}', '#{price_per_night}', '#{user_id}', '#{available_from}', '#{available_to}')
       RETURNING space_id, address, title, description, price_per_night, available_from, available_to;"
    )
    Spaces.new(space_id: result[0]['space_id'], address: result[0]['address'], title: result[0]['title'],
              description: result[0]['description'], price_per_night: result[0]['price_per_night'], owner: user_id,
              available_from: result[0]['available_from'], available_to: result[0]['available_to'])
  end

  def self.find(space_id)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE space_id = #{space_id};")
    Spaces.new(space_id: result[0]['space_id'], address: result[0]['address'], title: result[0]['title'],
    description: result[0]['description'], price_per_night: result[0]['price_per_night'], owner: result[0]['owner'],
    available_from: result[0]['available_from'], available_to: result[0]['available_to'])
  end

end
