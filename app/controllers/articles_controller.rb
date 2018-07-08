class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created" # handle this in views (application.html.erb)
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id]) #pull the id from the params passed in
  end

  private
  def article_params
    params.require(:article).permit(:title, :description) # for top level key :article, we permit the values of :title and :description
  end

end
