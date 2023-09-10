class ApplicationController < ActionController::API
  def serialize(data)
    ActiveModelSerializers::SerializableResource.new(data)
  end
end
