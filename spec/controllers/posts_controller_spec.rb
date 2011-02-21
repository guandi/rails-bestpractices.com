require 'spec_helper'

describe PostsController do
  context "index" do
    before :each do
      user = mock_model(User)
      controller.stub!(:authenticate_user!).and_return(true)
      controller.stub!(:current_user).and_return(user)
    end

    it "should not allow invalid nav param" do
      posts = mock([Post])
      Post.should_receive(:published).and_return(posts)
      posts.should_receive(:includes).with(:user, :tags).and_return(posts)
      posts.should_receive(:order).with("created_at desc").and_return(posts)
      posts.should_receive(:paginate).and_return(posts)
      get :index, :nav => "wssiasbhpnlgw", :order => "desc"
      response.should render_template("posts/index")
      assigns[:posts].should == posts
    end

    it "should not use implemented" do
      posts = mock([Post])
      Post.should_receive(:published).and_return(posts)
      posts.should_receive(:includes).with(:user, :tags).and_return(posts)
      posts.should_receive(:where).with(:implemented => true).and_return(posts)
      posts.should_receive(:order).with("created_at desc").and_return(posts)
      posts.should_receive(:paginate).and_return(posts)
      get :index, :nav => "implemented"
      response.should render_template("posts/index")
      assigns[:posts].should == posts
    end
  end
end
