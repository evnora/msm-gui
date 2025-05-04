class ActorsController < ApplicationController
  def index
    @list_of_actors = Actor.all
    render({ :template => "actors/index" })
  end

  def show
    matching_actors = Actor.where({ :id => params.fetch("path_id") })
    @actor = matching_actors.at(0)
    render({ :template => "actors/show" })
  end

  def create
    actor = Actor.new
    actor.name = params.fetch("the_name")
    actor.dob  = params.fetch("the_dob")
    actor.bio  = params.fetch("the_bio")
    actor.image = params.fetch("the_image")
    actor.save
    redirect_to("/actors")
  end

  def destroy
    matching_actors = Actor.where({ :id => params.fetch("an_id") })
    actor = matching_actors.at(0)
    actor.destroy
    redirect_to("/actors")
  end

  def update
    matching_actors = Actor.where({ :id => params.fetch("an_id") })
    actor = matching_actors.at(0)
    actor.name  = params.fetch("the_name")
    actor.dob   = params.fetch("the_dob")
    actor.bio   = params.fetch("the_bio")
    actor.image = params.fetch("the_image")
    actor.save
    redirect_to("/actors/#{ actor.id }")
  end
end
