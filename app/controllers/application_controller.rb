
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  post '/posts' do
    @post = Post.create(params)
    redirect '/posts'
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    # params.delete("_method")
    @post = Post.find(params[:id])

    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    # @post.update(params)
    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.destroy
    redirect '/posts'
  end
end
