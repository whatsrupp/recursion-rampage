require './models/expression_super_classes/expression'
require './models/addition'
require './models/multiplication'
require './models/division'
require './models/power'

require './lib/factory'
require './lib/state_checker'
include Factory
include StateChecker
require './lib/simplifier'


# require './lib/string'
require './lib/state_checker'
require './lib/math_regexes'
require './lib/string_final'


#FOR TESTING MAKE SURE TO REMOVE!
require 'pry'
