require 'forgery'

class RootScreen < PM::Screen
  title "Imaginary Friend"

  def will_present
  end

  def on_presented
    @loaded_views ||= begin
      add UIView.alloc.initWithFrame(self.frame), {
        background_color: UIColor.grayColor,
        text_color: UIColor.whiteColor
      }
      add UILabel.new, {
		  text: "This is awesome!",
		  font: UIFont.systemFontOfSize(18),
		  resize: [ :left, :right, :top, :bottom, :width, :height ], # autoresizingMask
		  left: 5, # These four attributes are used with CGRectMake
		  top: 5,
		  width: 20,
		  height: 20
		}
      true
    end
  end

  def on_appear
  end

  def will_appear
    set_attributes self.view, {
      backgroundColor: UIColor.whiteColor
    }
    ap Forgery(:basic).password
    ap Forgery(:internet).email_address
  end

  def will_disappear
  end

  def on_disappear
  end

  def will_dismiss
  end

  def on_dismiss
  end

  # custom method, triggered by tapping right nav bar button
  def go_to_next
    #open NextScreen
  end
end