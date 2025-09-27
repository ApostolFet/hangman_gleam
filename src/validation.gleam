import gleam/result
import gleam/string

pub type LetterValidationError {
  NotASingelLetter
  NotEnglishLetter
  AlreadyUsedLetter
}

pub fn validate_letter(
  letter: String,
  used_letters: String,
) -> Result(String, LetterValidationError) {
  let letter =
    letter
    |> string.trim
    |> string.lowercase

  use letter <- result.try(single_letter(letter))
  use letter <- result.try(english_letter(letter))
  use letter <- result.map(already_used(letter, used_letters))
  letter
}

fn single_letter(letter: String) -> Result(String, LetterValidationError) {
  case string.length(letter) == 1 {
    True -> Ok(letter)
    False -> Error(NotASingelLetter)
  }
}

fn english_letter(letter: String) -> Result(String, LetterValidationError) {
  let english_letters = "abcdefghijklmnopqrstuvwxyz"
  case string.contains(english_letters, letter) {
    True -> Ok(letter)
    False -> Error(NotEnglishLetter)
  }
}

fn already_used(
  letter: String,
  used_letters: String,
) -> Result(String, LetterValidationError) {
  case string.contains(used_letters, letter) {
    False -> Ok(letter)
    True -> Error(AlreadyUsedLetter)
  }
}
