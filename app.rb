require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/dog.db")
class Dog
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
end
DataMapper.finalize.auto_upgrade!

#index
get '/dogs' do
  @dogs = Dog.all
  puts @dogs
  erb :'dogs/index'
end

#new
get '/dogs/new' do
  erb :'dogs/new'
end

#create
post '/dogs' do
  Dog.create({:name => params[:breed]})
  redirect '/dogs'
end

#show
get '/dogs/:id' do
  @dogs = Dog.get(params[:id])
  erb :'dogs/show'
end

#edit
get '/dogs/:id/edit' do
  @dogs = Dog.get(params[:id])
  erb :'dogs/edit'
end

#update
patch '/dogs/:id' do
  dogs = Dog.get(params[:id])
  dogs.update({:name => params[:breed]})
  redirect '/dogs'
end

#delete
delete '/dogs/:id' do
  dogs = Dog.get(params[:id])
  dogs.destroy
  redirect '/dogs'
end
