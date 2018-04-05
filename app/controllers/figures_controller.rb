require 'pry'

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

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end



  post '/figures' do
    @figure = Figure.create(params[:figure])
    if params[:title]
      new_title = Title.create(params[:title])
      @figure.titles << new_title
    end
    if params[:landmark]
      new_landmark = Landmark.create(params[:landmark])
      @figure.landmarks << new_landmark
    end
    # @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @landmarks = Landmark.all
    @titles = Title.all
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if params[:title]
      new_title = Title.create(params[:title])
      @figure.titles << new_title
      # @figure.save
    end
    if params[:landmark]
      new_landmark = Landmark.create(params[:landmark])
      @figure.landmarks << new_landmark
      # @figure.save
    end
    redirect "/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.destroy
    redirect "/figures"
  end

end
