![Bitmaker](https://github.com/johncarlolopez/bitmaker-reference/blob/master/bitmakerlogo.svg)
# 03 - Dictionary Part 1: RESTful Routes
### Wednesday, Jan 10th

## Introducing REST
___

This assignment introduces a particular pattern (favoured by Rails as well as other web frameworks) for defining the routes of an app: REST. REST stands for representational state transfer, but as with many acronyms it's not terribly important for you to know that. When an app or a set of routes follow this pattern we would say we're using RESTful routes.

A RESTful route is composed of a URL that represents a particular piece of data (or "resource") in your app and an HTTP verb that represents which CRUD action is being performed. The majority of the routes we have been using so far (both in Sinatra and Rails) have been RESTful (we just haven't been calling them that up until now).

For example, the URL /articles/1043 could represent article number 1043 in an app of journal articles. The URL /authors/90 might represent the author with id 90 in the same app. The URL /articles/new might take you to a page where you can write a new article to add to the database. The URL GET /articles might show the entire list of articles in the database.

This route (using a GET request) would let the user view/read (the R in CRUD) article 1043:
```
GET /articles/1043
```
Whereas this route (using a PUT request) would let the user update (the U in CRUD) that same article:
```
PUT /articles/1043
```
In contrast, the routes GET /homepage or GET /welcome do not follow the REST pattern. That doesn't mean these routes are incorrect or bad to use; REST is just one philosophy for designing routes, and there are times when it's appropriate to stick to or deviate from this philosophy.

## Defining RESTful Routes in Rails
___
Rails provided a shorthand for defining RESTful, resource-based routes for all CRUD operations on your models.

If we want to quickly define RESTful routes for all CRUD operations for our dictionary app's Entry model, we can do so by adding this single line of code to routes.rb:
```
resources :entries
```
Add this code to your app and then run rails routes to see the eight new routes that have been defined:
```
    Prefix Verb   URI Pattern                 Controller#Action
   entries GET    /entries(.:format)          entries#index
           POST   /entries(.:format)          entries#create
 new_entry GET    /entries/new(.:format)      entries#new
edit_entry GET    /entries/:id/edit(.:format) entries#edit
     entry GET    /entries/:id(.:format)      entries#show
           PATCH  /entries/:id(.:format)      entries#update
           PUT    /entries/:id(.:format)      entries#update
           DELETE /entries/:id(.:format)      entries#destroy
```
Take a moment to think about which CRUD operation each of these routes is for.

If we don't want all CRUD operations for our model (if, for example, we never need to delete this type of data), we can list the routes to exclude, like so:
```
resources :entries, except: [:destroy]
```
Or we we have the option to list the routes we do want, if for example we only wanted to read this type of data but never create, update, or delete it:
```
resources :entries, only: [:index, :show]
```
Try this out in your own app and run rails routes to see how the output is affected.

When you're done experimenting, make sure to restore your code so all eight routes are there and then make a commit!

## Making the Controller
___
Returning to the original output of rails routes:
```
    Prefix Verb   URI Pattern                 Controller#Action
   entries GET    /entries(.:format)          entries#index
           POST   /entries(.:format)          entries#create
 new_entry GET    /entries/new(.:format)      entries#new
edit_entry GET    /entries/:id/edit(.:format) entries#edit
     entry GET    /entries/:id(.:format)      entries#show
           PATCH  /entries/:id(.:format)      entries#update
           PUT    /entries/:id(.:format)      entries#update
           DELETE /entries/:id(.:format)      entries#destroy
```
...we can see from the Controller#Action column that Rails is expecting us to have an "entries" controller with seven methods (index, create, new, edit, show, update, and destroy) to handle requests for these routes.

Furthermore, if we start our server and navigate to localhost:3000/entries in our browser, we should see a routing error that says "uninitialized constant EntriesController". So making this controller should be our next step.

Your task: Generate an entries controller (don't be afraid to look up the command for this if you don't remember it!)

Make another commit once you've generated the empty controller and its corresponding views sub-directory (app/views/entries).

## The Index Action
___
If you reload localhost:3000/entries in your browser you should see an unknown action error that says "The action 'index' could not be found for EntriesController".

This makes sense because the first line out our rails routes output reads:
```
   entries GET    /entries(.:format)          entries#index
```
...meaning the GET request we're making to the path /entries should be handled by an action called index in the entries controller.

Let's define that action in the controller:
```
def index
end
```
And let's make a view for this action to render, called index.html.erb in app/views/entries, and add a placeholder message.

app/view/entries/index.html.erb:
```
<p>This is the entries index page</p>
```
Finally, let's tell our controller to render this view file:
```
def index
  render :index
end
```
Now if you reload your browser, you should see the placeholder message appear.

Typically, this index page would display a collection of entries, and eventually we'll want to add some code to this controller method to pull entry data from the database, store it in some instance variables for the view to use, add some ERB to the view that uses those instance variables to display the data in a nice way, etc:
```
def index
  # here we'll define some @instance_variables to store data from the database for the views to use
  render :index
end
```
However, filling out our views is going to be part 2 of this assignment, and until we know what our view code will look like we don't know what instance variables we need to set up in our controller. So for now we can make a commit and move on to the next controller action.

## The Show Page
___
Whereas the index page usually shows a collection (such as a list of dictionary entries, for our app), the show page usually shows a single instance of that type of data (so a single dictionary definition, for our app).

1. Define a show action in the controller.
2. Create a show.html.erb view file with a short placeholder message.
3. Tell the controller action to render this view.
The route for the show page is a dynamic route that contains the id of the particular entry the user would like to see:
```
     entry GET    /entries/:id(.:format)      entries#show
```
This means that in order to test out our show page in the browser, we have to know the id of one of our entries. We can figure this out by going into the Rails console (rails c on the command line) and poking around at the data in our database (which we added when we ran rails db:seed at the beginning of this assignment).

In the console, try running Entry.all, Entry.first, Entry.last, or some other ActiveRecord method that will allow you to see the ids of some of your entries. Then, navigate to the show page in your browser by plugging one of those ids into the URL. You should see the placeholder message from your view.

To exit the Rails console you can either type exit or hit ctrl+d (not cmd+d).

The structure of this dynamic route also means that the params hash will contain :id as a key and the specific numeric id as the value.

Let's display this id in the view as part of our placeholder message, using ERB:

show.html.erb:
```
<p>This page will display information about entry number <%= params[:id] %></p>
```
Refresh your browser and make sure you see the id from the URL reflected in your placeholder message.

In part 2 of this assignment we'll elaborate on our view and controller code for this page to make it more useful. For now we're done here, so let's commit!

## The New Page
___
Typically the new page would display a form to let the user add another instance of this data type to the app (a new dictionary entry in this case). We're not yet prepared to make a fancy Rails form, so for this part of the assignment all you need to do is:

1. Define a method called new in your controller.
2. Make a new.html.erb view with a placeholder message like "the new entry form will go here later!".
3. Tell the controller method to render that view.
4. Try going to this page in your browser to make sure everything is working so far. Consult rails routes to remind yourself of the URL you should be using.  

Commit once it's working!

## The Create Action
___
If new is the route that displays the form to the user, then create is the route that handles the submission of that form. Create is a POST route, whereas the previous routes we've been working with have all been GET routes. Typically, routes that use HTTP verbs other than GET won't have views, so we aren't going to make a create.html.erb file. At the end of a POST request, instead of rendering a view, we usually want to redirect the user to one of our GET requests. So let's define our create action as so:
```
def create
  redirect_to entries_url
end
```
Here entries_url is a path helper method that returns the URL for our index page. We know we can use this helper method because of the prefix column in the output of rails routes:
```
    Prefix Verb   URI Pattern                 Controller#Action
   entries GET    /entries(.:format)          entries#index
```
See how under "Prefix" it says "entries"? entries + \_url = entries_url. This means when we say redirect_to entries_url, we're telling the controller to redirect our user to /entries (the value of the "URI Pattern" column of the same row).

We can't really test out this route until we make the form in part 2, because we can't easily send a POST request without having a form to submit. So, commit and let's move on!

## The Edit and Update Actions
___
Edit and update share the same relationship as new and create: edit is a GET route that shows the user a form (for modifying existing data, as opposed to adding brand new data) and update is a PUT or PATCH route that handles the form submissions.

Like the show page, these are both dynamic routes that contain an id:
```
edit_entry GET    /entries/:id/edit(.:format) entries#edit
...
...
           PATCH  /entries/:id(.:format)      entries#update
           PUT    /entries/:id(.:format)      entries#update
```
1. Define an edit method in the controller.
2. Make an edit.html.erb view with a placeholder message.
3. Tell the controller method to render that view.
4. Test out this route in your browser, plugging in one of the ids from your database
5. Commit!
6. Define an update method in your controller.
7. Tell the controller to redirect_to entry_url(params[:id]), which will send the user to the show page for the entry they were updating.
Don't hesitate to ask in instructor to break down that last bit of code for you if you're feeling uncertain about it.

We can't easily test out our update route today, since again it would require generating a non-GET request. Let's make a commit and leave the rest for part 2.

## The Destroy Action
___
The final route we have to take care of is the destroy action, which is used for removing data from the app. This is also a dynamic route containing an id, to allow the app to know which instance of this data type must be removed:
```
           DELETE /entries/:id(.:format)      entries#destroy
```
1. Define a destroy controller action.
2. Tell it to redirect the user to the index page.
3. Commit!
As with create and update, we can't easily test our destroy route in this part of the assignment.

**Rails Default Rendering Magic**
Let's try something weird: comment out the line of code in your index action that tells Rails which view to render:
```
def index
  # here we'll define some @instance_variables to store data from the database for the views to use
  # render :index
end
```
Now go to localhost:3000/entries in your browser. You should still be looking at the placeholder message from your index view, even though you never told Rails to render that view file. How is that working?

As you may recall from the intro to routing and controllers assignment, Rails controllers have default rendering behaviour that means in the absence of any code telling an action what to render or where to redirect, it will go looking in the corresponding views directory (views/entries in this case) for an erb file whose name matches the name of the controller action (so index.html.erb in the case of our index action).

This means that we can actually remove all the render code from our controller (but not the redirect_tos, since in those cases we're overriding the default rendering behaviour) in this case, since for index, show, new, and edit the default rendering behaviour is what we want.

You can choose for yourself whether you prefer to remove the render code or leave it be. Do whatever makes most sense to you!

## Done for now!
___
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
