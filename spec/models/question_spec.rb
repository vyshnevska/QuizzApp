require 'spec_helper'

describe Question, "model question" do
  before do
    @question = Question.create(:title => "testTitle")
  end

  #relations
  it { should have_many(:answers) }
  it { should belong_to(:quizz) }
  it { should accept_nested_attributes_for(:answers) }

  #validators
  it { should validate_presence_of(:title).with_message("Question title can't be blank.") }

  it "check title" do
    @question.title.should eql("testTitle")
  end

  context "invalid question obj" do
    before { @question.title = "" }
    it { should be_invalid }
  end

  after do
    @question.destroy
  end

end
