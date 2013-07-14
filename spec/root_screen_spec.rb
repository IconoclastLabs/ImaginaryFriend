describe "The root screen" do
	tests RootScreen

	it "loads the controller fine" do
		controller.should.not == nil
	end

  it "has the necessary buttons" do
    controller.instance_variable_get("@face_pictures_button").text.should == "Add Face Pictures"
  end
end