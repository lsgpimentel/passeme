module FollowUpHelper

  def follow_up_item_class(follow_up_item)
    if follow_up_item.filled?
      if follow_up_item.in_debt?
        "red"
      else
        "green"
      end
    else
      "grey"
    end
  end

end
