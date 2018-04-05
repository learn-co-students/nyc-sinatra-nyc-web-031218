require 'pry'

class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end


    get '/figures/new' do
      erb :"figures/new"
    end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end



  post '/figures' do
    @figure = Figure.create(params[:figure])
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    redirect "/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.destroy
    redirect "/figures"
  end

end
