require 'rails_helper'

RSpec.describe Task do
  let(:task) { create(:task) }

  describe "index" do
    context 'when find' do
      it "適切なステータスコードが返ってくること" do
        get tasks_path(task)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unfind' do
      it 'ステータスコード404が返ってくること' do
        get task_path(0)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "show" do
    context 'when find' do
      it "適切なステータスコードが返ってくること" do
        get task_path(task)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unfind' do
      it 'ステータスコード404が返ってくること' do
        get task_path(0)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "new" do
    context 'when find' do
      it "適切なステータスコードが返ってくること" do
        get new_task_path(task)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unfind' do
      it 'ステータスコード404が返ってくること' do
        get task_path(0)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "create" do
    context "when successfull" do
      subject(:create_path) { post tasks_path, params: params }

      let(:params) do
        { task: {
          title: "test title",
          body: "test body"
        } }
      end

      it "適切なステータスコードが返ってくること" do
        create_path
        expect(response).to have_http_status :found
      end

      it 'レコードが1つ増えること' do
        expect { create_path }.to change(described_class, :count).by(1)
      end

      it '作成されたレコードの値が意図したものになっていること' do
        create_path
        task = described_class.last
        expect(task.title).to eq(params[:task][:title])
      end

      it 'redirect先が正しいこと' do
        create_path
        expect(response).to redirect_to(root_path)
      end
    end

    context "when failure" do
      subject(:create_path) { post tasks_path, params: params }

      let(:params) do
        { task: {
          title: "",
          body: "test body"
        } }
      end

      it "適切なステータスコードが返ってくること" do
        create_path
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'レコードが増えないこと' do
        expect { create_path }.not_to change(described_class, :count)
      end

      it 'render 先が正しいこと' do
        create_path
        expect(response).to render_template(:new)
      end
    end
  end

  describe "edit" do
    context 'when find' do
      it "適切なステータスコードが返ってくること" do
        get edit_task_path(task)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unfind' do
      it 'ステータスコード404が返ってくること' do
        get task_path(0)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "update" do
    context "when successfull" do
      subject(:update_path) { put task_path(task), params: params }

      let(:params) do
        { task: {
          title: "test2 title",
          body: "test2 body"
        } }
      end

      it "適切なステータスコードが返ってくること" do
        update_path
        expect(response).to have_http_status :found
      end

      it 'レコードの値が意図した値に更新されていること' do
        update_path
        expect(task.reload.title).to eq 'test2 title'
      end

      it 'redirect 先が正しいこと' do
        update_path
        expect(response).to redirect_to(root_path)
      end
    end

    context "when failure" do
      subject(:update_path) { put task_path(task), params: params }

      let(:params) do
        { task: {
          title: "",
          body: "test2 body"
        } }
      end

      it "適切なステータスコードが返ってくること" do
        update_path
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'レコードが更新されないこと' do
        update_path
        expect(task.reload.title).to eq 'Greeting!'
      end

      it 'render 先が正しいこと' do
        update_path
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "destroy" do
    subject(:destroy_path) { delete task_path(task) }

    it "適切なステータスコードが返ってくること" do
      destroy_path
      expect(response).to have_http_status :found
    end

    it 'レコードが1つ減ること' do
      expect { destroy_path }.not_to change(described_class, :count)
    end

    it 'redirect先が正しいこと' do
      destroy_path
      expect(response).to redirect_to(root_path)
    end
  end
end
