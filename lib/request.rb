require_relative 'spaces'

class Request
  def initialize(request_id: , guest: , host: , space: , approved: nil, requested_date:)
    @request_id = request_id
    @guest = guest
    @host = host
    @space = space
    @requested_date = requested_date
    @approved = convert_sql_to_bool(approved)
  end
  attr_reader :request_id , :guest , :host , :space , :approved, :requested_date

  def self.approve(request_id)
    result = DatabaseConnection.query("UPDATE requests SET approved = true
     WHERE request_id = #{request_id}
     RETURNING request_id, guest, host, space, approved, requested_date;"
    )
    host = User.find(result[0]["host"])
    guest = User.find(result[0]["guest"])
    space = Spaces.find(result[0]["space"])
    request = Request.new(request_id: result[0]["request_id"],guest: guest,host: host, space: space, approved: result[0]["approved"], requested_date: result[0]['requested_date'])
    Request.update_booked_nights(request.space.space_id, request.requested_date)
    request
  end

  def self.update_booked_nights(space_id, booked_nights)
    space = Spaces.find(space_id)
    space.update_booked_nights(booked_nights, space_id)
  end

  def self.reject(request_id)
    result = DatabaseConnection.query("UPDATE requests SET approved = false
     WHERE request_id = #{request_id}
     RETURNING request_id, guest, host, space, approved, requested_date;"
    )
    host = User.find(result[0]["host"])
    guest = User.find(result[0]["guest"])
    space = Spaces.find(result[0]["space"])
    Request.new(request_id: result[0]["request_id"],guest: guest,host: host, space: space, approved: result[0]["approved"], requested_date: result[0]['requested_date'])
  end


  def self.create(guest:, host:, space:, requested_date:)
    result = DatabaseConnection.query(
      "INSERT INTO requests (guest, host, space, requested_date)
      VALUES(#{guest.user_id}, #{host.user_id}, #{space.space_id}, '#{requested_date}')
      RETURNING request_id;"
    )
    Request.new(request_id: result[0]['request_id'], guest: guest, host: host, space: space, approved: nil, requested_date: requested_date)
  end

  def self.all_user_received(host_id)
    result = DatabaseConnection.query("SELECT * FROM requests WHERE host = #{host_id};")
    array_of_results = []
    result.map { |request|
      host = User.find(request["host"])
      guest = User.find(request["guest"])
      space = Spaces.find(request["space"])
      Request.new(request_id: request['request_id'],guest: guest,host: host,space: space,approved: request['approved'], requested_date: request['requested_date'])
    }
  end

  def self.all_user_sent(guest_id)
    result = DatabaseConnection.query("SELECT * FROM requests WHERE guest = #{guest_id};")
    array_of_results = []
    result.map { |request|
      host = User.find(request["host"])
      guest = User.find(request["guest"])
      space = Spaces.find(request["space"])
      Request.new(request_id: request['request_id'],guest: guest,host: host,space: space,approved: request['approved'], requested_date: request['requested_date'])
    }
  end

  def convert_sql_to_bool(sql_input)
    if sql_input == "t"
      return true
    elsif sql_input == "f"
      return false
    else
      return sql_input
    end
  end
end
