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
    controller.instance_variable_get("@face_pictures_button").should.not == nil
    controller.instance_variable_get("@contacts_button").should.not == nil
  end

  it "adds face pictures when requested" do

    cur_count = 0
    figure_picture_count
    # give the above async process some time to finish
    wait 2.0 do
      cur_count = @picture_count
    end
    # Add pictures
    tap 'FacePicturesButton'

    wait 2.0 do
      cur_count.should.not == @picture_count
    end
  end

  def figure_picture_count
    assets_library = ALAssetsLibrary.alloc.init
    @picture_count = 0
    assets_library.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock:lambda do |group, stop|
      group.enumerateAssetsUsingBlock(lambda do |result, index, stop|
          unless result.nil?
            assetType = result.valueForProperty(ALAssetPropertyType)

            @picture_count += 1 if assetType == ALAssetTypePhoto
          end

      end) unless group.nil? # ObjC likes to end with nil objects
    end,
      failureBlock:lambda do |error|
        p "Failed to enumerate the asset groups"
      end)

    @picture_count
  end
end