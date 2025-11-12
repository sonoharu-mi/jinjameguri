class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model == "post"
      @records = Post.search_for(@content, @method)
    elsif @model == "group"
      @records = Group.search_for(@content, @method)
    else
      @records = []
    end
  end
end
