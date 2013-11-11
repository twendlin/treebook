json.array!(@statuses) do |status|
  json.extract! status, :name, :Asset, :Age, :Description
  json.url status_url(status, format: :json)
end
