class FiguresController < ApplicationController

  #read index

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  #get new figure form

  get '/figures/new' do
    @landmarks = Landmark.all
    erb :"figures/new"
  end

  #create new figure

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    redirect to "/figures/#{@figure.id}"
  end

  #read individual figure

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  #read edit form
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    erb :"figures/edit"
  end

  #edit figure
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  #delete figure

  delete '/figures/:id/delete' do
    Figure.destroy(params[:id])
    redirect to "/figures"
  end

end
