module FollowUpHelper

  def follow_up_item_class(event)
    if event.filled?
      if event.in_debt?
        "red"
      else
        "green"
      end
    else
      "grey"
    end
  end

end
