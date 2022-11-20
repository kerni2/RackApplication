class CheckFormat

  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }

  attr_reader :unknown_formats

  def initialize(time, formats = '')
    @time = time
    @formats = formats || ''
    @correct_formats = []
    @unknown_formats = []
  end

  def call
    @formats.split(',').each do |format|
      FORMATS[format.to_sym] ? @correct_formats << FORMATS[format.to_sym] : @unknown_formats << format
    end
  end

  def result
    @time.strftime(@correct_formats.join('-'))
  end

  def valid_format?
    @unknown_formats.empty?
  end
end
