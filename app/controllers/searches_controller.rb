class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @content = params[:content]
    @method = params[:method]

    @records = Post.search_for(@content, @method)
  end
end
