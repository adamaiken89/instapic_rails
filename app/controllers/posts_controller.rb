class PostsController < SecuredController
  include Pagy::Backend

  # GET /posts
  def index
    user_id, items, page, sort_order = extract_index_params
    unless page.positive?
      render json: { errors: [page: "Should be greater than zero"] }, status: :unprocessable_entity
      return
    end

    unless items.positive?
      render json: { errors: [items: "Should be greater than zero"] }, status: :unprocessable_entity
      return
    end

    @posts = Post.all
    @posts = @posts.where(user_id: user_id) if user_id
    @pagy, @posts = pagy(@posts, items: items, page: page)
    @posts = @posts.select(:description).order(created_at: sort_order).with_attached_image
    render json: {
      data: { posts: @posts.map { |post|
        post.as_json.merge({
          image: post.image.attached? ? url_for(post.image) : nil
        })
      } },
      meta: {
        items: @pagy.items,
        page: @pagy.page,
        total: @pagy.pages,
      }
    }
  rescue Pagy::OverflowError => e
    render json: { errors: [page: e.message] }, status: :unprocessable_entity
  end

  # POST /posts
  def create
    @post = Post.new(post_params.merge(user_id: @current_user.id))
    if @post.save
      render json: { data: { post: @post.as_json.merge({
        image: @post.image.attached? ? url_for(@post.image) : nil
      }) } }, status: :created
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  private
    def extract_index_params
      filter, sort, page = params.values_at(:filter, :sort, :page)
      user_id = if filter
        filter[:user_id]
      end

      items, page = if page
        page.values_at(:items, :page)
      end

      items = (items || Post::PAGINATION_DEFAULT_ITEMS).to_i
      page = (page || Post::PAGINATION_DEFAULT_PAGE).to_i
      sort_order = (sort == :desc ? :desc : :asc)

      [user_id, items, page, sort_order]
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:description, :image)
    end
end
