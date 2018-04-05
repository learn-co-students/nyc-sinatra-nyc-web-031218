class FiguresController < ApplicationController

  #read index

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  #get new figure form

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :"figures/new"
  end

  #create new figure

  post '/figures' do
    # binding.pry
    @figure = Figure.create(params[:figure])

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
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
    @titles = Title.all
    erb :"figures/edit"
  end

  #edit figure
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
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
