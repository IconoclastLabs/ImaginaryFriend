describe "The root screen" do
  tests RootScreen

  def controller
    @controller ||= RootScreen.new
    @controller.on_presented # force loading the view
    @controller
  end

  it "loads the controller fine" do
    controller.should.not == nil
  end

  it "has the necessary buttons" do
    fbutton = controller.instance_variable_get("@face_pictures_button").should.not == nil
    # check .titleLabel.text?
  end
end