class ItemsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    if params[:user_id]
      users = User.find(params[:user_id])
      items = users.items
    else
      items = Item.all
    end
    render json: items
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create 
    item = Item.create(permit_items)
    # byebug
    render json: item, status: 201
  end
  private

  def render_not_found
    render json: {error: 'user not found'}, status: 404
  end

  def permit_items
    params.permit(:name, :description, :price, :user_id)

  end

end



# def index
#   if params[:dog_house_id]
#     dog_house = DogHouse.find(params[:dog_house_id])
#     reviews = dog_house.reviews
#   else
#     reviews = Review.all
#   end
#   render json: reviews, include: :dog_house
#   end
#   reviews = Review.all
#   render json: reviews, include: :dog_house
# end