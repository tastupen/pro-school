class ApplicationController < ActionController::Base
  before_action :header

  def header
    @categories = Category.all
    @major_category_names = Category.major_categories
  end
end
