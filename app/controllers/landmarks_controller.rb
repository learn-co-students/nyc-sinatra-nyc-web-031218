class LandmarksController < ApplicationController

  #read/view index
  get '/landmarks' do
    @landmarks = Landmark.all

    erb :'landmarks/index'
  end

  #create a new landmark
  get '/landmarks/new' do

    erb :'landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])
    # binding.pry

    redirect :"landmarks/#{@landmark.id}"
  end

  #read/view a landmark
  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])

    erb :'landmarks/show'
  end

  #edit a landmark
  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])

    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    #some update
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])

    redirect :"/landmarks/#{@landmark.id}"

  end

  #delete a landmark
  delete '/landmarks/:id/delete' do
    # binding.pry
    Landmark.destroy(params[:id])

    redirect :"/landmarks"

  end

end
