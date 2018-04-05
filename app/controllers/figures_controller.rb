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
    @figure = Figure.create(name: params[:figure][:name])

    # array of title ids if selected
    @title_ids = params[:figure][:title_ids]

    #create figure-title assoc if checkboxes were selected
    if @title_ids
      @figure.title_ids = @title_ids
      @figure.save
      # @title_ids.each do |title_id|
      #   FigureTitle.create(figure_id: @figure.id, title_id: title_id)
      # end
    end

    #create figure-title assoc if new title
    if !params[:title][:name].empty?
      @new_title = Title.create(name: params[:title][:name])
      @figure.titles << @new_title
      @figure.save
      # FigureTitle.create(figure_id: @figure.id, title_id: @new_title.id)
    end

    # array of landmark ids if selected
    @landmark_ids = params[:figure][:landmark_ids]

    #creates figure-landmark assoc if checkboxes were selected
    if @landmark_ids
      @figure.landmark_ids = @landmark_ids
      @figure.save
      # @landmark_ids.each do |landmark_id|
      #   @landmark = Landmark.find(landmark_id)
      #   @landmark.figure_id = @figure.id
      #   @landmark.save
      # end
    end
    #creates figure-landmark assoc if new landmark
    if !params[:landmark][:name].empty?
      @new_landmark = Landmark.new(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      @figure.landmarks << @new_landmark
      @figure.save
      # @new_landmark.figure_id = @figure.id
      # @new_landmark.save
    end

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])
    @title_ids = params[:figure][:title_ids]

    if @title_ids
      @figure.title_ids = params[:figure][:title_ids]
      @figure.save
    end

    if !params[:title][:name].empty?
      @new_title = Title.create(name: params[:title][:name])
      @figure.titles << @new_title
      @figure.save
    end

    @landmark_ids = params[:figure][:landmark_ids]

    if @landmark_ids
      @figure.landmark_ids = @landmark_ids
      @figure.save
    end

    if !params[:landmark][:name].empty?
      @new_landmark = Landmark.new(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      @figure.landmarks << @new_landmark
      @figure.save
    end

    redirect "/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
    Figure.destroy(params[:id])
    redirect "/figures"
  end
end
