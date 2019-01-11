class PetsController < ApplicationController

  #Index
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  #New
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  #Create
  post '/pets' do
    # Create new pet
    @pet = Pet.create(params["pet"])
    # Add existing owner OR new one
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @owner.id
    end
    @pet.save
    redirect "/pets/#{@pet.id}"
  end

  #Show
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  #Edit
  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  #Update
  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @owner.id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
