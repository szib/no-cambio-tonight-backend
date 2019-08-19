class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :author, index: true
      # t.integer :commentable_id
      # t.string :commentable_type
      t.references :commentable, polymorphic: { default: 'Comment' }, index: true
      t.string :comment_text

      t.timestamps
    end

    # add_index :comments, [:commentable_type, :commentable_id]
    add_foreign_key :comments, :users, column: :author_id
  end
end
