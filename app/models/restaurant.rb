class Restaurant < ApplicationRecord
  belongs_to :category
  belongs_to :pref

  include Elasticsearch::Model

  index_name "restaurant_#{Rails.env}"

  settings do
    mappings dynamic: 'false' do
      indexes :name,      analyzer: 'kuromoji'
      indexes :name_kana, analyzer: 'kuromoji'

      indexes :zip
      indexes :address, analyzer: 'kuromoji'
      indexes :closed, type: 'boolean'
      indexes :created_at, type: 'date', format: 'date_time'
      indexes :pref do
        indexes :name, analyzer: 'keyword', index: 'not_analyzed'
      end
      indexes :category do
        indexes :name, analyzer: 'keyword', index: 'not_analyzed'
      end
    end
  end

  # インデクシング時に呼び出されるメソッド
  # マッピングのデータを返すようにする
  def as_indexed_json(_options = {})
    attributes
      .symbolize_keys
      .slice(:name, :name_kana, :zip, :address, :closed, :created_at)
      .merge(pref: { name: pref.name })
      .merge(category: { name: category.name })
  end

  def self.search(params = {})
    keyword = params[:q]

    search_definition = Elasticsearch::DSL::Search.search do
      query do
        if keyword.present?
          multi_match do
            query keyword
            fields %w( name name_kana address pref.name category.name )
          end
        else
          match_all
        end
      end
    end
    __elasticsearch__.search(search_definition)
  end
end
