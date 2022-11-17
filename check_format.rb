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

  def initialize(time, formats)
    @time = time
    @formats = formats || ''
    @correct_format = []
    @unknown_formats = []
  end

  def call
    @formats.split(',').each do |format|
      FORMATS[format.to_sym] ? @correct_format << FORMATS[format.to_sym] : @unknown_formats << format
    end
  end

  def result
    ordered = []

    %w(%Y %m %d %H %M %S).each do |f|
      ordered << f if @correct_format.include?(f)
    end

    @time.strftime(ordered.join('-'))
  end

  def valid_format?
    unknown_formats.empty?
  end
end
