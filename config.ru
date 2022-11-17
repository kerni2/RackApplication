require_relative 'time_rack'
require_relative 'application'

use TimeRack
run Application.new
