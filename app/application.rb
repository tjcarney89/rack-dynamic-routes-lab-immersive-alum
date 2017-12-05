class Application

  @@items = [Item.new("Carrots", "10"), Item.new("Apples", "20")]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last.capitalize
      item = @@items.find{|i| i.name == item_name}
      if item != nil
        resp.write item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"

    end
    resp.finish
  end
end
