class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
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
      @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
