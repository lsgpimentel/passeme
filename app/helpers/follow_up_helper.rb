module FollowUpHelper

  def follow_up_item_class(item)
    if item.in_debt?
      "debt-item"
    else
      "no-debt-item"
    end
  end

end
