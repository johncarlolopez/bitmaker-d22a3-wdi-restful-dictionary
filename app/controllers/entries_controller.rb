class EntriesController < ApplicationController
  def index
    # here we'll define some @instance_variables to store data from the database for the views to use
    render :index
  end
  def create
    redirect_to entries_url
  end
  def edit
    render :edit
  end
  def update
    redirect_to entry_url(params[:id])
  end
  def destroy
    redirect_to index_url
  end
end
