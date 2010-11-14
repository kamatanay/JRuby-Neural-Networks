require 'init'
require 'neural_networks/hopfield/hopfield_network'

network = HopfieldNetwork.trained_using([true,false,true])
p network.present [true,false,true]

INPUT_PATTERN  =  [ ["O O O O O ",
                     " O O O O O",
                     "O O O O O ",
                     " O O O O O",
                     "O O O O O ",
                     " O O O O O",
                     "O O O O O ",
                     " O O O O O",
                     "O O O O O ",
                     " O O O O O"  ],

                   [ "OO  OO  OO",
                     "OO  OO  OO",
                     "  OO  OO  ",
                     "  OO  OO  ",
                     "OO  OO  OO",
                     "OO  OO  OO",
                     "  OO  OO  ",
                     "  OO  OO  ",
                     "OO  OO  OO",
                     "OO  OO  OO"  ],

                   [ "OOOOO     ",
                     "OOOOO     ",
                     "OOOOO     ",
                     "OOOOO     ",
                     "OOOOO     ",
                     "     OOOOO",
                     "     OOOOO",
                     "     OOOOO",
                     "     OOOOO",
                     "     OOOOO"  ],

                   [ "O  O  O  O",
                     " O  O  O  ",
                     "  O  O  O ",
                     "O  O  O  O",
                     " O  O  O  ",
                     "  O  O  O ",
                     "O  O  O  O",
                     " O  O  O  ",
                     "  O  O  O ",
                     "O  O  O  O"  ],

                   [ "OOOOOOOOOO",
                     "O        O",
                     "O OOOOOO O",
                     "O O    O O",
                     "O O OO O O",
                     "O O OO O O",
                     "O O    O O",
                     "O OOOOOO O",
                     "O        O",
                     "OOOOOOOOOO"  ] ];

TEST_PATTERN = [ [ "          ",
                   "          ",
                   "          ",
                   "          ",
                   "          ",
                   " O O O O O",
                   "O O O O O ",
                   " O O O O O",
                   "O O O O O ",
                   " O O O O O"  ],

                 [ "OOO O    O",
                   " O  OOO OO",
                   "  O O OO O",
                   " OOO   O  ",
                   "OO  O  OOO",
                   " O OOO   O",
                   "O OO  O  O",
                   "   O OOO  ",
                   "OO OOO  O ",
                   " O  O  OOO"  ],

                 [ "OOOOO     ",
                   "O   O OOO ",
                   "O   O OOO ",
                   "O   O OOO ",
                   "OOOOO     ",
                   "     OOOOO",
                   " OOO O   O",
                   " OOO O   O",
                   " OOO O   O",
                   "     OOOOO"  ],

                 [ "O  OOOO  O",
                   "OO  OOOO  ",
                   "OOO  OOOO ",
                   "OOOO  OOOO",
                   " OOOO  OOO",
                   "  OOOO  OO",
                   "O  OOOO  O",
                   "OO  OOOO  ",
                   "OOO  OOOO ",
                   "OOOO  OOOO"  ],

                 [ "OOOOOOOOOO",
                   "O        O",
                   "O        O",
                   "O        O",
                   "O   OO   O",
                   "O   OO   O",
                   "O        O",
                   "O        O",
                   "O        O",
                   "OOOOOOOOOO"  ] ];



def inputs_to_boolean_pattern(string_pattern_array)
  string_pattern_array.join.chars.collect{|character| character == "O"}
end

def boolean_pattern_to_shape(boolean_pattern)
  array = (0...10).collect{|position| boolean_pattern[position*10...position*10+10] }
  array.each do |line|
    puts line.collect{|bool| bool ? "O" : " "}.join
  end
end


training_set = INPUT_PATTERN.collect{|pattern_array| inputs_to_boolean_pattern(pattern_array) }
network = HopfieldNetwork.trained_using(*training_set)
boolean_pattern_to_shape(network.present inputs_to_boolean_pattern(TEST_PATTERN[4]))


