class LandmarksController < ApplicationController

  #read all landmarks
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :"landmarks/index"
  end

  #create new landmark (1/2)
  get '/landmarks/new' do
    @figures = Figure.all
    erb :"landmarks/new"
  end

  #read one landmark
  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])

    # binding.pry
    if !(@landmark.figure_id == nil)
      @figure = Figure.find(@landmark.figure_id)
    end
    @figure
    erb :"landmarks/show"
  end

  #create new landmark (2/2)
  post '/landmarks' do
    @landmark = Landmark.new(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    if !params[:landmark][:figure_id].empty?
      @landmark.figure_id = params[:landmark][:figure_id]
    end
    @landmark.save
    # binding.pry
    redirect "/landmarks/#{ @landmark.id }"
  end

  #update a landmark (1/2)
  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    @figures = Figure.all
    erb :"landmarks/edit"
  end

  #update a landmark (2/2)
  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    @landmark.figure_id == params[:id]
    @landmark.save
    redirect "/landmarks/#{ @landmark.id }"
  end

  #delete a landmark
  delete '/landmarks/:id' do
    Landmark.delete(params[:id])
    redirect '/landmarks'
  end

end
