class FiguresController < ApplicationController

  get "/figures" do
    @figures = Figure.all
    erb :'figures/index'
  end

  get "/figures/new" do
    @landmarks = Landmark.all
    @titles = Title.all
    # binding.pry
    erb :'figures/new'
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end


  post "/figures" do
    @figure = Figure.create(name: params[:figure][:name])

    if params["title"]["name"].length > 0
    @figure.titles << Title.create(name: params["title"]["name"])
    end
    if params["landmark"]["name"].length > 0
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end
    if params[:figure][:title_ids] && !params[:figure][:title_ids].empty?
      params[:figure][:title_ids].each{|title_id| title_id.slice!("title_")
        @figure.titles << Title.find(title_id.to_i)

      }
    end

    if params[:figure][:landmark_ids] && !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].each{|landmark_id| landmark_id.slice!("landmark_")
        @figure.landmarks << Landmark.find(landmark_id.to_i)
      }
    end
    @figure.save
    redirect "figures/#{@figure.id}"
  end


  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'

  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])
    if params["title"]["name"].length > 0
    @figure.titles << Title.create(name: params["title"]["name"])
    end
    if params["landmark"]["name"].length > 0
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end

    if params[:figure][:title_ids] && !params[:figure][:title_ids].empty?
      params[:figure][:title_ids].each{|title_id| title_id.slice!("title_")
        @figure.titles << Title.find(title_id.to_i)

      }
    end

    if params[:figure][:landmark_ids] && !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].each{|landmark_id| landmark_id.slice!("landmark_")
        @figure.landmarks << Landmark.find(landmark_id.to_i)
      }
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
end
end
