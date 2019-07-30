require 'pg'
require 'bcrypt'
require_relative 'database_connection'
require_relative '../spec/database_connection_setup.rb'

class User

  attr_reader :email, :first_name, :last_name, :password, :mobile, :user_id

  def initialize(email:, first_name:, last_name:, password:, mobile:, user_id:)
    @email = email
    @first_name = first_name
    @last_name = last_name
    @password = password
    @mobile = mobile
    @user_id = user_id
  end

  def self.add(email:, first_name:, last_name:, password:, mobile:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (email, first_name, last_name, password, mobile) VALUES('#{email}',
                                    '#{first_name}', '#{last_name}', '#{encrypted_password}', '#{mobile}') RETURNING email, first_name, last_name, password, mobile, user_id;")
    User.new(email: result[0]['email'], first_name: result[0]['first_name'], last_name: result[0]['last_name'], password: result[0]['password'], mobile: result[0]['mobile'], user_id: result[0]['user_id'])
  end

  def self.authenticate(email, password)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password
    User.new(email: result[0]['email'], first_name: result[0]['first_name'], last_name: result[0]['last_name'], password: result[0]['password'], mobile: result[0]['mobile'], user_id: result[0]['user_id'])
  end

end
