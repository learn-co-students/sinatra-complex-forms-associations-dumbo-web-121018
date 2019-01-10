class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    # Create new pet
    @pet = Pet.create(params["pet"])
    # binding.pry
    # Add existing owner OR new one
    if params["owner"]["name"]
      @owner = Owner.create(params["owner"])
      @pet.update(owner_id: @owner.id)
    else
      @owner = Owner.find(params["owner"]["owner_id"][0])
      @pet.update(owner_id: @owner.id)
    end
    # binding.pry
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
