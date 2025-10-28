class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:shirine_name]
    @method = params[:method]

    @model == "post"
    @records = Post.search_for(@content, @method)
  end
end
