require 'rails_helper'

describe Restaurant, type: :model , elasticsearch: true do
  it "lanch es test" , elasticsearch: true do
    expect(Restaurant.search({query:{match_all:{}}}).count).to eq 0
  end
end
