class ListsController < ApplicationController

    before_action :set_list, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
  
    # GET /lists or /lists.json
    def index
  
      @lists = List.paginate(page: params[:page], per_page: 5)
      @categories = Category.all
     
    end
  
   
  
    # GET /lists/1 or /lists/1.json
    def show
      
    end
  
    # GET /lists/new
    def new
      @list = List.new
    end
  
    # GET /lists/1/edit
    def edit
    end
  
    # POST /lists or /lists.json
    def create
      
      @list = List.new(list_params)
      @list.user = current_user
      respond_to do |format|
        if @list.save
         format.html { redirect_to @list }
          format.json { render :show, status: :created, location: @list }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /lists/1 or /lists/1.json
    def update
      respond_to do |format|
        if @list.update(list_params)
          format.html { redirect_to @list }
          format.json { render :show, status: :ok, location: @list }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /articles/1 or /articles/1.json
    def destroy
      @list.destroy
      respond_to do |format|
      format.html { redirect_to lists_path}
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      
      def set_list
        @list = List.find(params[:id])
      end

    
    
      # Only allow a list of trusted parameters through.
  
      def list_params
        params.require(:list).permit(:title,:fulltext, :description, category_ids: [])
      end
  
      def require_same_user
        if current_user != @list.user && !current_user.admin?
        #  flash[:alert] = "You can only edit or delete your own article"
          redirect_to @list
        end
      end
  
      

end
