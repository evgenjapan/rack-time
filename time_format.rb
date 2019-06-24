class DateTimeFormat

  ALLOWED_FORMATS = {
      year: '%Y',
      month: '%m',
      day: '%d',
      hour: '%H',
      minute: '%M',
      second: '%S',
  }.freeze

  def initialize(format_str)
    @formats = format_str.split(',')
  end

  def get_time
    date_time = DateTime.now
    date_time.strftime(allowed_formats.join('-'))
  end

  def valid_format?
    errors.empty?
  end

  def errors
    @formats.reject { |format| ALLOWED_FORMATS.key? format.to_sym }
  end

  private

  def allowed_formats
    @formats.map { |format| ALLOWED_FORMATS[format.to_sym]}
  end

end
