class MyPortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: [:edit, :show, :update, :destroy]
  layout "my_portfolio"
  access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit, :sort]}, site_admin: :all

  def index
    @portfolio_items = MyPortfolio.by_position
  end

  def sort
    params[:order].each do |key, value|
      MyPortfolio.find(value[:id]).update(position: value[:position])
    end

    render nothing: true
  end

  def new
    @portfolio_item = MyPortfolio.new
  end

  def create
    @portfolio_item = MyPortfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
          format.html { redirect_to my_portfolios_path, notice: 'Your portfolio item is now live.' }
      else
        format.html { render :new }
      end
    end
  end

  def update

    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to my_portfolios_path, notice: 'Portfolio was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
    
  end

  def edit
    
  end

  def destroy

    @portfolio_item.destroy
    respond_to do |format|
      format.html { redirect_to my_portfolios_url, notice: 'Record was removed.' }
    end
  end

  private

  def portfolio_params
    params.require(:my_portfolio).permit(:title, 
                                      :subtitle, 
                                      :body,
                                      :main_image,
                                      :thumb_image, 
                                      technologies_attributes: [:name, :_destroy]
                                     )
  end

  def set_portfolio_item
    @portfolio_item = MyPortfolio.find(params[:id])
  end

end
