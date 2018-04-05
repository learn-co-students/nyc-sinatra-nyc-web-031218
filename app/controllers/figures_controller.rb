class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/new"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if params[:title]
      @figure.titles << Title.create(params[:title])
    end
    if params[:landmark]
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    @figure.save
    redirect "figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @titles = @figure.titles
    @landmarks = @figure.landmarks
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    if params[:figure][:title_ids]
      @figure.title_ids = params[:figure][:title_ids]
    end
      @figure.update(name: params[:figure][:name])
    if params[:figure][:landmark_ids]
      @figure.landmark_ids = params[:figure][:landmark_ids]
    end
    if params[:new_landmark]
      @figure.landmark << Landmark.create(name: params[:new_landmark], figure_id: @figure.id)
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
