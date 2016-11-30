class Api::V1::Merchants::FavoriteController < ApplicationController
  def show
    render json: Merchant.favorite_customer
  end
end
