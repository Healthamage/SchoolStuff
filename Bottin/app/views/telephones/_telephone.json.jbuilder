json.extract! telephone, :id, :phonenumber, :email, :belongs_to, :created_at, :updated_at
json.url telephone_url(telephone, format: :json)