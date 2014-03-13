require_relative '../spec_helper'

describe Api::TaskListsController do
  describe "GET index" do
    let!(:task_lists) { create_list(:task_list, 3) }

    before do
      get :index, format: :json
    end

    it "should be successful" do
      expect(response).to be_success
    end

    it "should contains correct lists" do
      expect(json.size).to eq 3
      expect(json.first["name"]).to eq task_lists.first.name
    end
  end

  it "Task List table must be empty" do
    expect(TaskList.count).to eq 0
  end

  describe "POST create" do
    before do
      post :create, task_list: {name: "New tasks list"}, format: :json
    end

    it "should return new task" do
      expect(json.kind_of?(Hash)).to be_true
      expect(json["id"].kind_of?(Integer)).to be_true
      expect(json["name"]).to eq "New tasks list"
    end

    it "should save new task" do
      expect(TaskList.count).to eq 1
      expect(TaskList.first.name).to eq "New tasks list"
    end
  end
end