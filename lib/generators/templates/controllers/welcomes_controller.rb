class WelcomesController < ApplicationController
  def index
    @users = User.order("created_at desc").page(params[:page])
    @articles = Article.order("created_at desc").page(params[:page])
  end

  def users_search
    case params[:category]
      when 'email'
        @users = User.where("email like '%#{params[:search]}%'").order("created_at desc").page(params[:page])
      when 'name'
        @users = User.where("name like '%#{params[:search]}%'").order("created_at desc").page(params[:page])
    end
    render 'index'
  end

  def articles_search
    search = params[:term].present? ? params[:term] : nil
    @articles = if search
      Article.search(search, fields: [:title, :content])
    else
      Article.Article.order("created_at desc").page(params[:page])
    end 
    render 'index'
  end
end
