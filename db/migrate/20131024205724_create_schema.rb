class CreateSchema < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
    end

    create_table :spans do |t|
      t.belongs_to :project
      t.string :name
      t.string :status
      t.datetime :created_at,      :null => false
    end

    add_foreign_key(:spans, :projects)
    add_index(:spans, :project_id)

    create_table :categories do |t|
      t.string :name
    end

    create_table :indicators do |t|
      t.belongs_to :category
      t.string :name
      t.text :description
      t.string :one_label
      t.string :five_label
      t.integer :sort_order
    end

    add_foreign_key(:indicators, :categories)
    add_index(:indicators, :category_id)

    create_table :ratings do |t|
      t.belongs_to :span
      t.belongs_to :indicator
      t.integer :score
    end

    add_foreign_key(:ratings, :spans)
    add_foreign_key(:ratings, :indicators)
    add_index(:ratings, :span_id)
    add_index(:ratings, :indicator_id)

    create_table :comments do |t|
      t.belongs_to :span
      t.belongs_to :indicator
      t.text :comment
    end

    add_foreign_key(:comments, :spans)
    add_foreign_key(:comments, :indicators)
    add_index(:comments, :span_id)
    add_index(:comments, :indicator_id)
  end
end
