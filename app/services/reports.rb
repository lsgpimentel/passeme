class Reports

  attr_accessor :follow_up_not_studied_reason
  attr_accessor :expected_and_accomplished
  attr_accessor :study_hours_evolution
  

  def initialize(timetable)
    @timetable = timetable
  end

  def generate_all
    generate_follow_up_not_studied_reason
    generate_expected_and_accomplished
    generate_study_hours_evolution

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

  def generate_expected_and_accomplished
    start_date = Date.current - 1.month
    end_date = Date.current

    expected = EventInstance.calendar_occurrences_between(@timetable.calendar, start_date, end_date).map { |ei| ei.duration_in_hours }.inject(0, :+)
    accomplished = @timetable.follow_up_items.studied.in_period(start_date, end_date).map{ |f| f.studied_time_in_hours }.inject(0, :+)

    @expected_and_accomplished = {}
    @expected_and_accomplished[:labels] = []
    @expected_and_accomplished[:hours] = []

    @expected_and_accomplished[:labels].push([0, I18n.t('reports.expected_and_accomplished.labels.expected')])
    @expected_and_accomplished[:hours].push([0, expected])

    @expected_and_accomplished[:labels].push([1, I18n.t('reports.expected_and_accomplished.labels.accomplished')])
    @expected_and_accomplished[:hours].push([1, accomplished])

    @expected_and_accomplished

  end

  def generate_study_hours_evolution
    @study_hours_evolution = {}
    @study_hours_evolution[:labels] = []
    @study_hours_evolution[:hours] = []

    I18n.t('date.abbr_month_names').each_with_index do |month, index|
      @study_hours_evolution[:labels].push([index, month])

      start_date = Date.current.beginning_of_year + index.months
      end_date = start_date.end_of_month
      studied_in_month = @timetable.follow_up_items.studied.in_period(start_date, end_date).map{ |f| f.studied_time_in_hours }.inject(0, :+)
      @study_hours_evolution[:hours].push([index, studied_in_month])
    end

    @study_hours_evolution

  end



  private

end
