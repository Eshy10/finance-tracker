class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  validates :name, :sticker, presence: true
  def self.new_lookup(tickler_symbol)    
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key], 
                                  endpoint: 'https://sandbox.iexapis.com/v1')
    begin                             
    new(sticker: tickler_symbol, name: client.company(tickler_symbol).company_name, last_price:client.price(tickler_symbol))
    rescue => exception
      return nil
    end                         
  end

  def self.check_db(tickler_symbol)
    Stock.where(sticker: tickler_symbol).first
  end
end
