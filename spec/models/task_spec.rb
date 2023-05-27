require 'rails_helper'

RSpec.describe Task do
  describe 'validation' do
    context "when successfull" do
      let(:task) { create(:task) }

      it "タイトル、本文の場合は有効である" do
        # Taskのそれぞれのカラムに対して値を入れてオブジェクト化する
        expect(task).to be_valid
        # オブジェクトをexpectに渡した時に、有効である(be valid)という意味になります
      end
    end

    context "when failure" do
      let(:task) { build(:task, title: nil) }

      it "タイトルがない場合、無効である" do
        expect(task).to be_invalid
      end
    end
  end
end
