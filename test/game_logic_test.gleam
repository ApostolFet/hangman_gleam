import gleeunit/should

import game_logic
import game_state

pub fn is_win_true_test() {
  let win_state = game_state.GameState("test", 0, "tes")

  let result = game_logic.is_win(win_state)

  should.be_true(result)
}

pub fn is_win_false_test() {
  let state = game_state.GameState("test", 0, "t")

  let result = game_logic.is_win(state)

  should.be_false(result)
}
