# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

major_category_names = ["夏のスポーツ", "冬のスポーツ"]

summer_sports_categories = ["野球", "サッカー", "水泳", "テニス", "ゴルフ", "バスケットボール", "柔道", "レスリング", "体操", "ラグビー", "アメフト", "スケートボード", "卓球"]
winter_sports_categories = ["フィギュアスケート", "スキー・スノーボード", "カーリング", "その他"]

major_category_names.each do |major_category_name|
  if major_category_name == "夏のスポーツ"
    summer_sports_categories.each do |summer_sports_category|
      Category.create( 
        name: summer_sports_category, 
        description: summer_sports_category, 
        major_category_name: major_category_name 
      ) 
    end
  elsif major_category_name == "冬のスポーツ"
    winter_sports_categories.each do |winter_sports_category|
      Category.create( 
        name: winter_sports_category, 
        description: winter_sports_category, 
        major_category_name: major_category_name 
      ) 
    end
  end
end