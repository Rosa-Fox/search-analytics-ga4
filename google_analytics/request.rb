class Request
  attr_accessor :offset, :limit
  def initialize(offset, limit)
    @offset = offset
    @limit = limit
  end

  def analytics_data
    ::Google::Analytics::Data::V1beta::RunReportRequest.new({
      property: "properties/330577055",
      date_ranges: [
        date_range
      ],
      dimensions: [page_path, page_title],
      metrics: [screen_page_views],
      offset: offset,
      limit: limit,
      return_property_quota: true
    })
  end

private

  def page_path
    #https://developers.google.com/analytics/devguides/reporting/data/v1/api-schema#dimensions
    Google::Analytics::Data::V1beta::Dimension.new(
      name: "pagePath"
    )
  end

  def page_title
    #https://developers.google.com/analytics/devguides/reporting/data/v1/api-schema#dimensions

    Google::Analytics::Data::V1beta::Dimension.new(
      name: "pageTitle"
    )
  end

  def screen_page_views
    #https://developers.google.com/analytics/devguides/reporting/data/v1/api-schema#metrics
    Google::Analytics::Data::V1beta::Metric.new(
      name: "screenPageViews"
    )
  end

  def date_range
    #TODO pass number of days in as CLI argument
    start_date = Date.today - 1
    end_date = Date.today

    { start_date: start_date.to_s, end_date: end_date.to_s}
  end
end