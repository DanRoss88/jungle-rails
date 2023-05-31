class CartsController < ApplicationController
  before_action :require_login, except: [:show]
  def show
    if cart.empty? 
      @empty_cart_notice = "Looks like your cart is empty, continue shopping here :)"
    else
      @empty_cart_notice = nil
    end
  end

  def add_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, +1)
    # byebug
    redirect_back fallback_location: root_path
  end

  def remove_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, -1)

    redirect_back fallback_location: root_path
  end

  private

  def modify_cart_delta(product_id, delta)
    cart[product_id] = (cart[product_id] || 0) + delta
    cart.delete(product_id) if cart[product_id] < 1
    update_cart cart
  end
  
  def require_login
    unless logged_in?
      flash.now[:alert] = "You must be logged in to access this page."
      redirect_to login_path 
  end
end
end
