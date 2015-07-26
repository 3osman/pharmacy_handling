json.array!(@medicines) do |medicine|
  json.extract! medicine, :id, :name, :availability, :quantity, :usage, :side_effects
  json.url medicine_url(medicine, format: :json)
end
