class Reports

  attr_accessor :follow_up_not_studied_reason
  
  def initialize(timetable)
    @timetable = timetable
  end

  def generate_all
    generate_follow_up_not_studied_reason

    self
  end

  def generate_follow_up_not_studied_reason
    items_studied_debt = @timetable.follow_up_items.studied_debt

    @follow_up_not_studied_reason = []

    FollowUpItem.debt_reason.values.each do |i|
      @follow_up_not_studied_reason.push({
        label: i.text,
        data: items_studied_debt.with_debt_reason(i).count
      })
    end

    @follow_up_not_studied_reason

  end

  private

end
