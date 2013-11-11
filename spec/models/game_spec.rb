require 'spec_helper'

describe Game do
  #relations
  it { should have_many(:game_details) }
  it { should belong_to(:user) }
  it { should belong_to(:quizz) }

  #validators
  # it { should validate_presence_of(:user_id)}
  # it { should validate_presence_of(:quizz_id)}

  context "check states" do
    before do
      user = User.create!(:name =>"testUser", :email => "test@qwerty.com", :password=>"password")
      quizz = Quizz.create!(:description =>"testQuizz")
      @game = Game.create(:user_id => user.id, :quizz_id => quizz.id)
    end

    it "default state should be draft" do
      @game.state.should eql("draft")
    end

    it "state should be started" do
      @game.set_to_started!
      @game.state.should eql("started")
    end

    it "state should be finished" do
      @game.set_to_started!
      @game.set_to_finished!
      @game.state.should eql("finished")
    end

    after do
      @game.destroy
    end
  end

  describe "check score" do
    before do
      user = User.create!(:name =>"user", :email => "user@qwerty.com", :password=>"password")
      quizz = Quizz.create!(:description =>"testQuizz")
      question1 = Question.create(:title => "testTitle1", :quizz_id => quizz.id)
      question2 = Question.create(:title => "testTitle2", :quizz_id => quizz.id)
      @game = Game.create(:user_id => user.id, :quizz_id => quizz.id)
    end

    it "should set maximum score to 20" do
      @game.set_maximum_score.should eql(20)   
    end    
  end

end
