class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index # shows all spices 
        render json: Spice.all
    end

    def create # creates a spice 
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def show # shows individual spices 
        spice = find_spice
        render json: spice 
    end

    def update # updates a spice 
        spice = find_spice
        spice.update(spice_params)
        render json: spice 
    end
    
    def destroy # deletes a spice
        spice = find_spice 
        spice.destroy
        head :no_content 
    end
    
    private 

    def find_spice
        Spice.find(params[:id])
    end

    def spice_params 
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found_response
        render json: { error:'Spice not found' }, status: :not_found
    end
end
