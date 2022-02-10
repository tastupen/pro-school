class SearchsController < ApplicationController
  def search
    @range = params[:range]
    
    @ward = params[:word]

    @words= @ward.split(/[[:blank:]]+/)

    @admins = []
    @lessons = []
    
    if @range == "先生"
      @words.each do |word|
        @admins += Admin.search(word)
        @pages = Kaminari.paginate_array(@admins).page(params[:page]).per(5)
      end
    else
      @words.each do |word|
        @lessons += Lesson.search(word)
        @pages = Kaminari.paginate_array(@lessons).page(params[:page]).per(5)
      end
    end
    @user = current_user
  end

  def admin_profile
    @admin = Admin.find(params[:id])
    @lessons  = @admin.lessons.all
  end
end
