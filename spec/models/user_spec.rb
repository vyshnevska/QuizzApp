require 'spec_helper'

describe User do
  it { should have_many(:games) }
  it { should have_many(:quizzs).through(:games) }
  it { should have_many(:friends).through(:friendships) }
  it { should have_many(:friendships) }
  it { should have_many(:inverse_friends).through(:inverse_friendships) }
  
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  context "user games activity" do
    before do
        @user = User.create!(:name =>"testUser", :email => "test@qwerty.com", :password=>"password")
        @quizz = Quizz.create!(:description =>"testQuizz")
      end

    describe "assigned games" do
      before do
        game = Game.create(:user_id => @user.id, :quizz_id => @quizz.id)
      end

      it "user should have 1 assigned game" do
        @user.assigned_games.should eql(1)
      end
    end

    describe "passed games" do
      before do
        @game1 = Game.create!(:user_id => @user.id, :quizz_id => @quizz.id, :points => 100)
        game_detail1 = GameDetail.create(:id => 1, :game_id => @game1.id, :question_id => 1, :answer_id => 1)
        @game2 = Game.create!(:user_id => @user.id, :quizz_id => @quizz.id, :points => 80)
        game_detail2 = GameDetail.create(:id => 2, :game_id => @game2.id, :question_id => 1, :answer_id => 2)
      end

      it "user should have 2 passed games" do
        @user.passed_games.count.should eql(2)
      end

      it "user's total score should be 180" do
        @user.total_score.should eql(180)
      end

      it "maximum score for usershould be 300" do
        @user.maximum_score.should eql(300)
      end

      after do
        @game1.destroy
        @game2.destroy
      end
    end
  end
end
