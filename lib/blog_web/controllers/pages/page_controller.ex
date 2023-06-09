defmodule BlogWeb.PageController do
  use BlogWeb, :controller
  alias Blog.Posts

  def home(conn, _params) do
    posts = Posts.list_posts()

    render(conn, :home, posts: posts)
  end

  def show(conn, %{"slug" => slug} = _params) do
    post = Posts.get_post_by_slug!(slug)

    post = Map.put(post, :content, Earmark.as_html!(post.content))
    render(conn, :show, post: post, page_title: post.slug)
  end
end
