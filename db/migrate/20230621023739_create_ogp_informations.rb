class CreateOgpInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :ogp_informations do |t|

      t.timestamps
    end
  end
end
