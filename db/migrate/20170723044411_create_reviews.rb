class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer     'potatoes'
      t.text        'comments'
      t.references  'moviegoer'
      t.references  'movie'
    end
  end
end
