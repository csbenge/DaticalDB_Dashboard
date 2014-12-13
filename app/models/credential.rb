class Credential < ActiveRecord::Base
  belongs_to :user
  belongs_to :schema
end
