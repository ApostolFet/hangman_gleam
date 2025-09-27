import gleam/list
import gleam/string

import display
import game_state
import interface
import words

pub fn start_game() {
  display.greating()

  case interface.entry_game() {
    True -> {
      case words.get_word() {
        Ok(word) -> play_game(game_state.GameState(word, 0, ""))
        Error(error) -> display.display_file_error(error)
      }
    }
    False -> {
      display.end_game()
    }
  }
}

fn play_game(state: game_state.GameState) {
  let max_error = 7

  let char = interface.get_letter(state.used_letters)

  let count_errors = case string.contains(state.word, char) {
    True -> state.count_error
    False -> state.count_error + 1
  }

  let new_used_letters = string.append(state.used_letters, char)

  let new_game_state =
    game_state.GameState(
      ..state,
      count_error: count_errors,
      used_letters: new_used_letters,
    )

  display.display_game_state(new_game_state)

  let is_user_win = is_win(new_game_state)

  case count_errors >= max_error, is_user_win {
    True, _ -> display.display_lose(new_game_state)
    _, True -> display.display_win(new_game_state)
    False, False -> play_game(new_game_state)
  }
}

pub fn is_win(state: game_state.GameState) -> Bool {
  list.all(string.to_graphemes(state.word), fn(letter) {
    string.contains(state.used_letters, letter)
  })
}
