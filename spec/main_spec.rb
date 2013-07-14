describe "Application 'ImaginaryFriend'" do
  before do
    @app = UIApplication.sharedApplication
    @root_view = @app.windows[0].rootViewController.view
  end

  it "has one window" do
    @app.windows.size.should == 1
  end

  it "starts with at least one subview" do
    @root_view.subviews.size.should > 0
  end

end
