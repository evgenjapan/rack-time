class DateTimeFormat

  attr_reader :allowed_formats

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
    set_allowed_formats
    p @allowed_formats
  end

  def get_time
    date_time = DateTime.now
    date_time.strftime(@allowed_formats.join('-'))
  end

  def errors
    @formats.reject { |format| ALLOWED_FORMATS.key?(format.to_sym) }
  end

  def valid_format?
    errors.empty?
  end

  private

  def set_allowed_formats
    @allowed_formats  = valid_format? ? @formats.map { |format| ALLOWED_FORMATS[format.to_sym]} : []
  end

end
