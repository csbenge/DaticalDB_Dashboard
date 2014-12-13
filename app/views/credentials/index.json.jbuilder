json.array!(@credentials) do |credential|
  json.extract! credential, :id, :user_id, :schema_id, :snapshot, :status, :forecast, :deploy
  json.url credential_url(credential, format: :json)
end
