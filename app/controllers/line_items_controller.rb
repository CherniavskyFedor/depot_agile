class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :update, :destroy]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    respond_to do |format|
      if @line_item.save
        session[:counter] = 0
        format.html { redirect_to store_url }
        format.js { @current_item = @line_item}
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.error, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  #def update
   # if @line_item.update(line_item_params)
      #redirect_to store_url, notice: 'Line item was successfully updated.'
    #else
      #render action: 'edit'
    #end
  #end
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html {redirect_to store_url, notice: 'Line item was successfully updated'}
        format.js
        format.json { render action: 'show', status: :update, location: @line_item}
      else
        format.html { render action: 'edit' }
        format.js
        format.json { render json: @line_item.error, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /line_items/1
  def destroy
    respond_to do |format|
      if @line_item.destroy
        format.html { redirect_to store_url, notice: 'Line item was successfully destroyed.' }
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity)
    end
end
