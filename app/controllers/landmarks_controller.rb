class LandmarksController < ApplicationController

  get "/landmarks" do
    @landmarks = Landmark.all
      erb :'landmarks/index'
  end

  get "/landmarks/new" do
    @figures = Figure.all
    erb :'landmarks/new'
  end
  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params[:id])
    @figures = Figure.all

    erb :'landmarks/edit'
  end
  get "/landmarks/:id" do
  @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end
  post "/landmarks" do
    @landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])

      if !params[:figure_name].empty?
      @landmark.figure = Figure.create(name: params[:figure_name])
      else
       @landmark.figure = Figure.find(params[:figure_id])
    end
    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end

  post "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])

    @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])

      if !params[:figure_name].empty?
      @landmark.figure = Figure.create(name: params[:figure_name])
      else
       @landmark.figure = Figure.find(params[:figure_id])
    end
    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end
end
