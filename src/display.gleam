import gleam/io
import gleam/list
import gleam/string

import simplifile

import game_state
import validation

pub fn greating() {
  io.println("Welcome to Hangman!")
  io.println("Guess the word before the man is hanged!")
}

pub fn display_game_state(state: game_state.GameState) {
  let mask = get_mask(state.word, state.used_letters)
  display_picture(state)
  io.println("Word: " <> mask)
  io.println("Used Letter: " <> state.used_letters)
}

pub fn display_win(_: game_state.GameState) {
  io.println("🎉 Victory! You've outsmarted the hangman!")
  io.println("The prisoner is free – thanks to your amazing guessing skills!")
  io.println("Well done, you're our hero of the day! 🏅")
}

pub fn display_lose(state: game_state.GameState) {
  io.println("Your Lose. Word: " <> state.word)
  io.println("😢 Oh no! The hangman got you this time...")
  io.println("The secret word was: " <> state.word)
  io.println(
    "Better luck next round – the hangman wasn't feeling generous today!",
  )
  io.println("Don't worry, even Einstein lost at Hangman sometimes (probably)")
}

pub fn end_game() {
  io.println("The outdoors is free and has better sound effects! 🎯")
}

pub fn display_validation_error(error: validation.LetterValidationError) {
  case error {
    validation.NotASingelLetter ->
      io.println("Easy does it! Enter just one letter to play fair. 🏃‍♂️")
    validation.NotEnglishLetter ->
      io.println("Whoa! That’s not a letter! We need an English one (a-z). 🔄")
    validation.AlreadyUsedLetter ->
      io.println("Oops! That letter’s been taken. Find a fresh one! 🤫")
  }
}

pub fn display_file_error(error: simplifile.FileError) {
  case error {
    simplifile.Enoent ->
      io.println("File with words not found in location ./files/word.txt")
    simplifile.Unknown(msg) -> io.println(msg)
    _ -> io.println("Unexpected error when read file")
  }
}

pub fn get_mask(word: String, used_letters: String) -> String {
  string.join(
    list.map(string.to_graphemes(word), fn(letter) {
      case string.contains(used_letters, letter) {
        True -> letter
        False -> "*"
      }
    }),
    "",
  )
}

const pictures = #(
  "
  
     
     
 
 
 
 
 
 |__________|
 ",
  "
 __________
 |    
 |    
 |
 |
 |
 |
 |
 |__________|
 ",
  "
 __________
 |    |
 |    O
 |    |
 |
 |
 |
 |
 |_________|
 ",
  "
 __________
 |    |
 |    O
 |   \\|
 |
 |
 |
 |
 |____|____|
 ",
  "
 __________
 |    |
 |    O
 |   \\|/
 |
 |
 |
 |
 |_________|
 ",
  "
 __________
 |    |
 |    O
 |   \\|/
 |    |
 |
 |
 |
 |_________|
 ",
  "
 __________
 |    |
 |    O
 |   \\|/
 |    |
 |   /
 |
 |
 |_________|
 ",
  "
 __________
 |    |
 |    O
 |  \\|/
 |    |
 |   / \\
 |
 |
 |_________|
 ",
)

pub fn display_picture(state: game_state.GameState) {
  let picture = case state.count_error {
    0 -> pictures.0
    1 -> pictures.1
    2 -> pictures.2
    3 -> pictures.3
    4 -> pictures.4
    5 -> pictures.5
    6 -> pictures.6
    7 -> pictures.7
    _ -> panic as "Max errors overload"
  }
  io.println(picture)
}
