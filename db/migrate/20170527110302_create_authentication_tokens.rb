class CreateAuthenticationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :authentication_tokens do |t|
      t.string :token
      t.references :user

      t.timestamps
    end
  end
end
