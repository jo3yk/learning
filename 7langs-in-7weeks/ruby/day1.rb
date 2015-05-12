# Day 1 Self-Study

# FIND:
# Ruby API - http://ruby-doc.org/core-2.2.2/
# Programming Ruby: The Pragmatic Programmer's Guide - http://ruby-doc.com/docs/ProgrammingRuby/
# A method that substitutes part of a string - String.sub
# Info about Ruby regexes - http://ruby-doc.org/core-2.1.1/Regexp.html, http://rubular.com/
# Info about Ruby ranges - http://ruby-doc.org/core-2.2.0/Range.html

# DO:
# 1. Print the string 'Hello, world' - exercise_1
# 2. For the string "Hello, Ruby", find the index of the word 'Ruby' - exercise_2
# 3. Print your name ten times - exercise_3
# 4. Print the string 'This is sentence number 1.' where the number 1 changes from 1 to 10 - exercise_4
# 5. Run a Ruby program from a file - this file!
# 6. Bonus - Write a program that picks a random number. Let the player guess the number, telling the player whether the guess is too low or too high - exercise_6.

def exercise_1
  puts 'Hello, world'
end

def exercise_2
  str = 'Hello, Ruby'
  find = 'Ruby'
  index = str.index(find)
  puts "Index of #{find} in #{str} is #{index}"
end

def exercise_3
  name = 'Jo'
  count = 10
  for i in 0...count
    puts "My name is #{name} (#{i+1})"
  end
end

def exercise_4
  for i in 0...10
    puts "This is sentence number #{i}."
  end
end

def handle_input(input, this_rand)
  if input[0] == 'Q' or input [0] == 'q'
    puts "You're giving up? Ok, the answer was #{this_rand}"
    return FALSE
  elsif is_number(input)
    if input.to_i == this_rand
      puts 'Congratulations! You guessed correctly.'
    elsif input.to_i < this_rand
      puts 'Sorry - too low'
    else
      puts 'Sorry - too high'
    end
    return TRUE
  else
    puts "Please enter a number (last input: #{input.strip})"
    return TRUE
  end
end

def is_number(string)
  Integer(string)
  return TRUE
rescue ArgumentError
  return FALSE
end

def exercise_6
  max_rand = 10000
  this_rand = rand(max_rand)
  puts 'Guess a number or press \'Q\' to quit'
  input = gets
  while (handle_input(input, this_rand))
    input = gets
  end
end

exercise_6

