require_relative '../spec_helper'

describe Api::TasksController do
  let!(:task_list) { create(:task_list) }

  describe "GET index" do

    before do
      2.times do |i|
        create(:task, {
          note: "Task ##{i+1}",
          task_list: task_list
        })
      end

      get :index, task_list_id: task_list.id, format: :json
    end

    it "should be successful" do
      expect(response).to be_success
    end

    it "should contains correct tasks" do
      expect(json.size).to eq 2
      expect(json.first["note"]).to eq "Task #1"
    end
  end

  it "Task List table must be empty" do
    expect(Task.count).to eq 0
  end

  describe "POST create" do
    before do
      post :create, {
        task: {
          note: "New task"
        },
        task_list_id: task_list.id,
        format: :json
      }
    end

    it "should return new task" do
      expect(json.kind_of?(Hash)).to be_true
      expect(json["id"].kind_of?(Integer)).to be_true
      expect(json["note"]).to eq "New task"
    end

    it "should save new task" do
      expect(Task.count).to eq 1
      expect(Task.first.note).to eq "New task"
    end
  end
end