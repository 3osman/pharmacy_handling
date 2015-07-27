json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :age, :first_check_in
  json.url patient_url(patient, format: :json)
end
