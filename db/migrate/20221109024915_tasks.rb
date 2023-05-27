class Tasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, comment: "タスク詳細" do |t|
      t.string  :title, null: false, comment: "タイトル"
      t.string  :body, comment: "本文"
      t.date :limit, comment: "タスクの期限"
      t.integer :status, comment: "ステータス"
      t.timestamps
    end
  end
end
