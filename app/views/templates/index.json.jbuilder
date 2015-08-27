json.array!(@templates) do |template|
  json.extract! template, :id, :name, :symptoms, :duration
  json.url template_url(template, format: :json)
end
