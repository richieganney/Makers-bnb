require 'pg'
require_relative 'database_connection'
require_relative '../spec/database_connection_setup.rb'

class User

  attr_reader :email, :first_name, :last_name, :password, :mobile

  def initialize(email:, first_name:, last_name:, password:, mobile:)
    @email = email
    @first_name = first_name
    @last_name = last_name
    @password = password
    @mobile = mobile
  end

  def self.add(email:, first_name:, last_name:, password:, mobile:)
    result = DatabaseConnection.query("INSERT INTO users (email, first_name, last_name, password, mobile) VALUES('#{email}', 
                                    '#{first_name}', '#{last_name}', '#{password}', '#{mobile}') RETURNING email, first_name, last_name, password, mobile;")
    User.new(email: result[0]['email'], first_name: result[0]['first_name'], last_name: result[0]['last_name'], password: result[0]['password'], mobile: result[0]['mobile'])
  end
    
end