class Request
  attr_reader :request_id, :guest, :host, :space, :approved

  def initialize(request_id:, guest:, host:, space:, approved:)
    @request_id = request_id
    @guest = guest
    @host = host
    @space = space
    @approved = approved
  end

  def self.create(guest:, host:, space:)
    result = DatabaseConnection.query(
      "INSERT INTO requests (guest, host, space)
      VALUES(#{guest}, #{host}, #{space})
      RETURNING request_id;"
    )
    Request.new(request_id: result[0]['request_id'], guest: guest, host: host, space: space, approved: nil)
  end
end
