require 'forgery'

class RootScreen < PM::Screen
  include SugarCube::CoreGraphics # gives us the Rect() command
  title "Imaginary Friend"

  def will_present
  end

  def on_presented
    @loaded_views ||= begin
      

			@face_pictures_button = add UIButton.buttonWithType(UIButtonTypeRoundedRect), {
	      frame: Rect([20, 80], [280, 40]),
	      "setTitle:forState:" => [ "Add Face Pictures", UIControlStateNormal ],
	      "addTarget:action:forControlEvents" => [ self, :add_face_pictures, UIControlEventTouchUpInside ]
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
	    
      true
    end
  end

  def on_appear
  end

  def will_appear
    # These work:
    #ap Forgery(:basic).password
    #ap Forgery(:internet).email_address
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
    addressBook = ABAddressBookCreate()
    50.times do
      record = ABPersonCreate()
     
      multi = ABMultiValueCreateMutable(KABStringPropertyType)
     
      email = Forgery(:internet).email_address
      ABMultiValueAddValueAndLabel(multi, email, KABHomeLabel, nil)
       
      first_name = Forgery::Name.first_name
      last_name = Forgery::Name.last_name
     
      # add the first name
      ABRecordSetValue(record, KABPersonFirstNameProperty, first_name, nil)    
      # add the last name
      ABRecordSetValue(record, KABPersonLastNameProperty, last_name, nil)       
      # add the home email
      ABRecordSetValue(record, KABPersonEmailProperty, multi, nil)
       
      # add the record to the address book
      ABAddressBookAddRecord(addressBook, record, nil)
    end
     
    # save the address book
    ABAddressBookSave(addressBook, nil)
     
  end
end