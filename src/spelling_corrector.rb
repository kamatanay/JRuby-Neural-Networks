def text_from_file(file_name)
  File.open(file_name){ |f| f.read }
end

def words_in text
  text.downcase.scan(/[a-z]+/)
end

def train_using features
  model = Hash.new(1)
  features.each {|f| model[f] += 1 }
  return model
end

NWORDS = train_using words_in(text_from_file '../resource/spelling_training_file.txt')
LETTERS = ("a".."z").to_a

def edits1 word
  n = word.length
  deletion = (0...n).collect {|index| word[0...index]+word[index+1..-1] }
  transposition = (0...n-1).collect {|index| word[0...index] + word[index+1,1] + word[index,1] + word[index+2..-1] }
  alteration = (0...n).inject([]) {|array, index| array + LETTERS.collect {|letter| word[0...index] + letter + word[index+1..-1] } }
  insertion = (0..n).inject([]) {|array, index| array + LETTERS.collect {|letter| word[0...index] + letter + word[index..-1] } }
  result = deletion + transposition + alteration + insertion
  result.uniq unless result.empty?
end

def known_edits2 word
  result = edits1(word).inject([]){|array, edit_word| array + edits1(edit_word).find_all{|new_word| NWORDS.has_key? new_word } }
  result.empty? ? nil : result.uniq
end

def known words
  result = words.find_all {|w| NWORDS.has_key?(w) }
  result.empty? ? nil : result
end

def correct word
  (known([word]) or known(edits1(word)) or known_edits2(word) or
    [word]).max {|a,b| NWORDS[a] <=> NWORDS[b] }
end

puts correct("recursion")