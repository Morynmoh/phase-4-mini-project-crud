class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index
      render json: Spice.all,  status: :ok
    end
  
    def show
      spice = find_spice
      render json: spice, except: [:created_at, :updated_at], status: :ok
    end
  
    def create
      spice = Spice.create(spice_params)
      render json: spice, except: [:created_at, :updated_at], status: :created
    end
  
    def destroy
      spice = find_spice
      spice.destroy
      render json: { message: 'plant deleted' }, status: :no_content
    end
  
    def update
      spice = find_spice
      spice.update(spice_params)
      render json: spice, except: [:updated_at, :created_at], status: :accepted
    end
  
    private
  
    def render_not_found_response
      render json: { error: 'Not Found' }, status: :not_found
    end
  
    def find_spice
      spice = Spice.find(params[:id])
    end
  
    def spice_params
      params.permit(:title, :description, :image, :notes, :rating)
    end
end
