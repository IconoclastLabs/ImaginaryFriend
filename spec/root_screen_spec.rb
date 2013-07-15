describe "The root screen" do
  tests RootScreen

  it "loads the controller fine" do
    controller.should.not == nil
  end

  it "has the necessary buttons" do
    # Why the hell is this nil in test but comes back fine in running?
    fbutton = controller.instance_variable_get("@face_pictures_button").titleLabel.text
    p fbutton
  end
end