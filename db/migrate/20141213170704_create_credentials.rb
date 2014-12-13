class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.references :user, index: true
      t.references :schema, index: true
      t.boolean :snapshot
      t.boolean :status
      t.boolean :forecast
      t.boolean :deploy

      t.timestamps
    end
  end
end
