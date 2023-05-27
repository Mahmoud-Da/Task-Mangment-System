require 'rails_helper'

RSpec.describe Category do
  context "when successfull" do
    let(:category) { create(:category) }

    it "名前がある時に" do
      # Categoryのそれぞれのカラムに対して値を入れてオブジェクト化する
      expect(category).to be_valid
      # オブジェクトをexpectに渡した時に、有効である(be valid)という意味になります
    end
  end

  context "when failure" do
    let(:category) { build(:category, name: nil) }

    it "名前がないとき" do
      expect(category).to be_invalid
    end
  end
end
