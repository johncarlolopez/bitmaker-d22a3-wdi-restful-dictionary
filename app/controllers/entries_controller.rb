class EntriesController < ApplicationController
  def index
    @entries = Entry.all
    render :index
  end
  def show
    @entry = Entry.find(params[:id])
  end
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      redirect_to entries_url
    else
      redirect_to new_entry_path
    end
  end
  def new
    @entry = Entry.new
  end
  def edit
    @entry = Entry.find(params[:id])
    render :edit
  end
  def update
    @entry = Entry.find(params[:id])
    @entry.update(entry_params)

    if @entry.save
      redirect_to entry_path
    else
      redirect_to entry_path(params[:id])
    end
  end
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to entries_path
  end
  def entry_params
    params.require(:entry).permit(:word, :language, :definition)
  end
end
