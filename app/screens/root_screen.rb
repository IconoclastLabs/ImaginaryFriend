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
    # asking whether we are already authorized
    if AddressBook.authorized?
      puts "This app is authorized?"
    else
      puts "This app is not authorized?"
    end
    people = AddressBook::Person.all
    ap people
    if AddressBook.authorized?
      puts "This app is authorized?"
    else
      puts "This app is not authorized?"
    end
    iPhoneAddressBook = ABAddressBookCreate()
    person = AddressBook::Person.create(
            :first_name => Forgery::Name.first_name, 
            :last_name => Forgery::Name.last_name, 
            :email => [{ :value => Forgery(:internet).email_address , :label => 'Home'}], :phones => [{ :value => rand(10 ** 10).to_s, :label => 'Mobile'}])
    ap "person: #{person}"
    #if AddressBook.request_authorization do #|granted|
      # this block is invoked sometime later
      #ap granted
      # if granted
      #   ap "do something now that the user has said yes"
      #   50.times do
      #     ap "looping"
      #     person = AddressBook::Person.create(
      #       :first_name => Forgery::Name.first_name, 
      #       :last_name => Forgery::Name.last_name, 
      #       :email => [{ :value => Forgery(:internet).email_address , :label => 'Home'}], :phones => [{ :value => rand(10 ** 10).to_s, :label => 'Mobile'}])
      #     ap person
      #   end
      # else
      #   ap "do something now that the user has said no"
      # end
    #  ap "access granted"
    #else
    #  ap "authorization not granted"
    #end
  end
end