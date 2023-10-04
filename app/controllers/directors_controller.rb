class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def update
    #Get the ID out of params
    d_id = params.fetch("the_id")

    #Look up the existing record

    matching_records = Director.where({:id => d_id})

    the_director = matching_records.at(0)
    #Overwrite each column with the values from user inputs

    the_director.name = params.fetch("the_name")
    the_director.dob = params.fetch("the_dob")
    the_director.bio = params.fetch("the_bio")
    the_director.image = params.fetch("the_image")

    
    #Save
    the_director.save
    #Redirect to movie details page

    redirect_to("/directors/#{the_director.id}")
  end

  def create
    # Retrieve the user's inputs from params

    d = Director.new

    d.name = params.fetch("the_name")
    d.dob = params.fetch("the_dob")
    d.bio = params.fetch("the_bio")
    d.image = params.fetch("the_image")

    d.save

    redirect_to("/directors")


    # Create a record in the movie table
    # Populate each colum with the user input
    # Save

    # Redirect the user back to the /movies URL



  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Director.where({:id => the_id})

    the_director = matching_records.at(0)

    the_director.destroy

    redirect_to("/directors")

  end


  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
