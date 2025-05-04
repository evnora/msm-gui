class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors

    render({ :template => "directors/index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_directors = Director.where({ :id => the_id })
    @director = matching_directors.at(0)

    # if you want to list their movies:
    # @filmography = Movie.where({ :director_id => @director.id })

    render({ :template => "directors/show" })
  end

  def create
    director = Director.new
    director.name = params.fetch("query_name")
    # if you have other fields on your create form (dob, image, bio):
    # director.dob   = params.fetch("query_dob")
    # director.image = params.fetch("query_image", "")
    # director.bio   = params.fetch("query_bio", "")
    director.save

    redirect_to("/directors")
  end

  def update
    the_id = params.fetch("an_id")
    matching_directors = Director.where({ :id => the_id })
    director = matching_directors.at(0)

    director.image = params.fetch("query_image")
    # you can also update name, bio, etc. if your form includes them
    # director.name = params.fetch("query_name")
    director.save

    redirect_to("/directors/#{the_id}")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_directors = Director.where({ :id => the_id })
    director = matching_directors.at(0)

    director.destroy

    redirect_to("/directors")
  end

  def max_dob
    # youngest director (largest dob)
    youngest_collection = Director.where({}).order({ :dob => :desc })
    @director = youngest_collection.at(0)

    render({ :template => "directors/max_dob" })
  end

  def min_dob
    # eldest director (smallest dob)
    eldest_collection = Director.where({}).order({ :dob => :asc })
    @director = eldest_collection.at(0)

    render({ :template => "directors/min_dob" })
  end
end
