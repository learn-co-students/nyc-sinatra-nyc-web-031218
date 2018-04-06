class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :'/figures/show'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params[:title].empty?
      @figure.titles << Title.create(params[:title])
    end

    if !params[:landmark].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])


    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    redirect to "/figures/#{@figure.id}"
  end
end
