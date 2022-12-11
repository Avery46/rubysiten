class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  def new
      @category = Category.new
  end
  def create
      @category = Category.new(category_params)

      respond_to do |format|
          if @category.save
           format.html { redirect_to @category  }
            format.json { render :show, status: :created, location: @category }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
      end

  end
  def index
      @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
      @category = Category.find(params[:id])
      @lists = @category.lists.paginate(page: params[:page], per_page: 5)
  end

  private 

  def category_params 
      params.require(:category).permit(:name)
  end
  def require_admin
      if !(logged_in? && current_user.admin?)
     #   flash[:alert] = "Only admins can perform that action"
        redirect_to categories_path
      end
  end
  def edit
      @category = Category.find(params: [:id]) 
  end

  def update
      @category = Category.find(params: [:id]) 
      if @category.update(category_params)
        #  flash[:notice] = "Category name updeted successfully"
          redirect_to @category
      else
          render 'edit'
      end



  end

end
      
  