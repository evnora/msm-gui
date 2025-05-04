class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors

    render({ :template => "actors/index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_actors = Actor.where({ :id => the_id })
    @actor = matching_actors.at(0)

    render({ :template => "actors/show" })
  end

  def create
    actor = Actor.new
    actor.name  = params.fetch("query_name")
    # if you have an image field on your create form uncomment:
    # actor.image = params.fetch("query_image", "")
    actor.save

    redirect_to("/actors")
  end

  def update
    the_id = params.fetch("an_id")
    matching_actors = Actor.where({ :id => the_id })
    actor = matching_actors.at(0)

    actor.image = params.fetch("query_image")
    # if you also allow changing the name:
    # actor.name = params.fetch("query_name")
    actor.save

    redirect_to("/actors/#{the_id}")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_actors = Actor.where({ :id => the_id })
    actor = matching_actors.at(0)

    actor.destroy

    redirect_to("/actors")
  end
end
