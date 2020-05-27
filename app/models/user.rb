class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(tickler_symbol)
    stock = Stock.check_db(tickler_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(tickler_symbol)
    under_stock_limit? && !stock_already_tracked?(tickler_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end
