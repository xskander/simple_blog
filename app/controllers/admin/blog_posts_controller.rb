class Admin::BlogPostsController < Admin::BaseController

  before_filter :find_blog_post!, :only => [:edit, :update, :destroy]

  def index
    @blog_posts = BlogPost.unscoped
  end

  def new
    @blog_post = BlogPost.create
    redirect_to edit_admin_blog_post_path(@blog_post.id)
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      flash[:notice] = t('.flash_notice')
      redirect_to admin_blog_posts_path
    else
      flash[:alert] = t('.flash_alert')
      render :action => :edit
    end
  end

  def destroy
    @blog_post.destroy
    flash[:notice] = t('.flash_notice')
    redirect_to admin_blog_posts_path
  end

  def get_tags
    @tags = BlogPost.find_tags(tag_params)
    render json: @tags.map(&:name)
  end

  private

    def tag_params
      params.permit(:term)[:term]
    end

    def blog_post_params
      params.require(:blog_post).permit(:title, :body, :description, :published_at, :tag_list, :keyword_list)
    end

    def find_blog_post!
      @blog_post = BlogPost.unscoped.find_by!(params.permit(:id))
    end
end
