def encode (payload)
  JWT.encode(payload, Rails.application.credentials[:secret_key_base])
end