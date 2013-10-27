require 'spec_helper'
# require "mocha/setup"

describe QuizzsController do
  it "should redirect to sign in page" do
    get :index
    response.should redirect_to(new_user_session_path)
  end

  describe "GET #index" do # :focus
    before do
      @user = User.create!(:name =>"testUser", :email => "test@qwerty.com", :password=>"password")
      sign_in @user
    end
    context "GET #index" do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
        flash.now[:notice].should == "There is no active quizz now. Please create new."
        flash[:notice].should_not be_nil
      end

      it "loads all of the posts into @posts" do
        quizz1, quizz2 = Quizz.create!(:description=>"first"), Quizz.create!(:description=>"second")
        get :index

        expect(assigns(:quizzes)).to match_array([quizz1, quizz2])
      end
    end

    context "GET #complete" do
      before do
        @quizz = Quizz.create(:description =>"testQuizz")
        get :complete, :id => @quizz.id
      end

      it "renders the index template" do
        if @quizz.set_to_completed
          @quizz.status.should eql("completed")
          response.should redirect_to(quizzs_path)
          flash[:notice].should_not be_nil
          flash.now[:notice].should == "Quizz# #{@quizz.id} is completed!"
        end
        
      end

      after do 
        @quizz.destroy
      end


      # it "loads all of the posts into @posts" do
      #   quizz1, quizz2 = Quizz.create!(:description=>"first"), Quizz.create!(:description=>"second")
      #   get :index

      #   expect(assigns(:quizzes)).to match_array([quizz1, quizz2])
      # end
    end
    after do 
      sign_out @user
      @user.destroy
    end
  end
end