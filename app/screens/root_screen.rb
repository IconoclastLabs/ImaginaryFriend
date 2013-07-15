require 'forgery'

class RootScreen < PM::Screen
  include SugarCube::CoreGraphics # gives us the Rect() command
  title "Imaginary Friend"

  def will_present
  end

  def on_presented

    @loaded_views ||= begin
      if Device.simulator?
  			@face_pictures_button = add UIButton.buttonWithType(UIButtonTypeRoundedRect), {
  	      frame: Rect([20, 80], [280, 40]),
  	      "setTitle:forState:" => [ "Add Face Pictures", UIControlStateNormal ],
  	      "addTarget:action:forControlEvents" => [ self, :add_face_pictures, UIControlEventTouchUpInside ],
          accessibilityLabel: "FacePicturesButton"
  	    }
  	    # @landscape_pictures_button = add UIButton.buttonWithType(UIButtonTypeRoundedRect), {
        #   frame: Rect([20.0, 170.0], [280.0, 40.0]),
  	    #   "setTitle:forState:" => [ "Add Landscape Pictures", UIControlStateNormal ],
  	    #   "addTarget:action:forControlEvents" => [ self, :add_landscape_pictures, UIControlEventTouchUpInside ]
  	    # }
  	    @contacts_button = add UIButton.buttonWithType(UIButtonTypeRoundedRect), {
  	      frame: Rect([20.0, 260.0], [280.0, 40.0]),
  	      "setTitle:forState:" => [ "Add Random Contacts ", UIControlStateNormal ],
  	      "addTarget:action:forControlEvents" => [ self, :add_contacts, UIControlEventTouchUpInside ]
  	    }
	    else
        @warning_label = add UILabel.new, {
          text: "This only works on the simulator.",
          backgroundColor: :blue.uicolor,
          textAlignment: :center.uialignment,
          frame: Rect([20.0, 260.0], [280.0, 40.0])
        }
      end
      true
    end
  end

  def on_appear
  end

  def will_appear
  end

  def will_disappear
  end

  def on_disappear
  end

  def will_dismiss
  end

  def on_dismiss
  end

  def add_face_pictures
  	ap "adding face pictures"
  	faces = [ "faces/cage1.jpg".uiimage,
  		"faces/cage2.jpg".uiimage,
  		"faces/cage3.jpg".uiimage,
  		"faces/cage4.jpg".uiimage,
  		"faces/cage5.jpg".uiimage,
  		"faces/cage6.jpg".uiimage,
  		"faces/cage7.jpg".uiimage]
  	faces.each do |face|
  		UIImageWriteToSavedPhotosAlbum(face, nil, nil, nil);
  	end
  end

  # def add_landscape_pictures
  # 	ap "adding landscape pictures"
  # end

  def add_contacts
  	ap "adding contacts"
    # asking whether we are already authorized
    AddressBook.request_authorization unless AddressBook.authorized?

    
    if AddressBook.authorized?
      25.times do
        person = AddressBook::Person.create(
            :first_name => Forgery::Name.first_name, 
            :last_name => Forgery::Name.last_name, 
            :email => [{ :value => Forgery(:internet).email_address , :label => 'Home'}], :phones => [{ :value => rand(10 ** 10).to_s, :label => 'Mobile'}])
      end
    else
      #ap "This app is not authorized to access the address book."
    end
    #enVd
  end
end