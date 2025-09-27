import input.{input}

import display
import validation

pub fn entry_game() -> Bool {
  retry_entry_game(0, "Ready to play? (Y/n) >>> ")
}

fn retry_entry_game(n: Int, label: String) -> Bool {
  let max_retry = 3
  case my_input(label), n >= max_retry {
    "Y", _ -> True
    "n", _ -> False
    _, True -> False
    input, False ->
      retry_entry_game(
        n + 1,
        "❗Invalid input: "
          <> input
          <> "\nValid options: "
          <> "\n    Y - Start the game"
          <> "\n    n - Exit the game"
          <> "\n\nReady to play? (Y/n) >>> ",
      )
  }
}

pub fn get_letter(used_letters) {
  let letter = my_input("Letter: \n>>> ")
  case validation.validate_letter(letter, used_letters) {
    Ok(letter) -> letter
    Error(error) -> {
      display.display_validation_error(error)
      get_letter(used_letters)
    }
  }
}

fn my_input(label) -> String {
  let user_input_result = input(label)
  case user_input_result {
    Ok(input) -> input
    Error(_) -> my_input(label)
  }
}
