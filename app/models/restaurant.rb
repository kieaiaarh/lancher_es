class Restaurant < ApplicationRecord
  belongs_to :category
  belongs_to :pref

  include Elasticsearch::Model

  index_name "restaurant_#{Rails.env}"
end
