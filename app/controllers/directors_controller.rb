class DirectorsController < ApplicationController
  def index
    @list_of_directors = Director.all
    render({ :template => "directors/index" })
  end

  def show
    matching_directors = Director.where({ :id => params.fetch("path_id") })
    @director = matching_directors.at(0)
    render({ :template => "directors/show" })
  end

  def create
    director = Director.new
    director.name  = params.fetch("the_name")
    director.dob   = params.fetch("the_dob")
    director.bio   = params.fetch("the_bio")
    director.image = params.fetch("the_image")
    director.save
    redirect_to("/directors")
  end

  def destroy
    matching_directors = Director.where({ :id => params.fetch("an_id") })
    director = matching_directors.at(0)
    director.destroy
    redirect_to("/directors")
  end

  def update
    matching_directors = Director.where({ :id => params.fetch("an_id") })
    director = matching_directors.at(0)
    director.name  = params.fetch("the_name")
    director.dob   = params.fetch("the_dob")
    director.bio   = params.fetch("the_bio")
    director.image = params.fetch("the_image")
    director.save
    redirect_to("/directors/#{ director.id }")
  end

  def max_dob
    ordered_directors = Director.order({ :dob => :desc })
    @youngest = ordered_directors.at(0)

    # render the view file app/views/directors/youngest.html.erb
    render({ :template => "directors/youngest" })
  end

  def min_dob
    ordered_directors = Director.order({ :dob => :asc })
    @eldest = ordered_directors.at(0)

    # render the view file app/views/directors/eldest.html.erb
    render({ :template => "directors/eldest" })
  end
end
