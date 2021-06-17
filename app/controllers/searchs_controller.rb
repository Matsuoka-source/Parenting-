class SearchsController < ApplicationController
  def search
    # viewのform_tagで選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入したsearch_forを@recordsに代入。
    @records = search_for(@model, @method, @content)
  end

  private
  def search_for(model, method, content)
    # 選択したモデルがuserだったら
    if model == 'user'
      # 選択した検索方法がが完全一致だったら
      if method == 'perfect'
        User.where(name: content)
      # 選択した検索方法がが部分一致だったら
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
    # 選択したモデルがpostだったら
    elsif model == 'post'
      if method == 'perfect'
        Post.where(title: content)
      else
        Post.where('title LIKE ?', '%'+content+'%')
      end
    end
  end
end
