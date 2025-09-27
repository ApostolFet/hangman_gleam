import gleeunit/should

import validation

pub fn validate_letter_lower_ok_test() {
  let valid_letter = "k"
  let used_letters = "tes"
  let result = validation.validate_letter(valid_letter, used_letters)

  should.be_ok(result)
  |> should.equal(valid_letter)
}

pub fn validate_letter_trim_ok_test() {
  let valid_letter = " k  "
  let expected_letter = "k"
  let used_letters = "tes"
  let result = validation.validate_letter(valid_letter, used_letters)

  should.be_ok(result)
  |> should.equal(expected_letter)
}

pub fn validate_letter_upper_ok_test() {
  let valid_letter = "K"
  let expected_letter = "k"
  let used_letters = "tes"
  let result = validation.validate_letter(valid_letter, used_letters)

  should.be_ok(result)
  |> should.equal(expected_letter)
}

pub fn validate_letter_not_single_letter_error_test() {
  let valid_letter = "kk"
  let expected_error = validation.NotASingelLetter
  let used_letters = "tes"
  let result = validation.validate_letter(valid_letter, used_letters)

  should.be_error(result)
  |> should.equal(expected_error)
}

pub fn validate_letter_not_english_letter_error_test() {
  let valid_letter = "!"
  let expected_error = validation.NotEnglishLetter
  let used_letters = "tes"
  let result = validation.validate_letter(valid_letter, used_letters)

  should.be_error(result)
  |> should.equal(expected_error)
}

pub fn validate_letter_letter_alerady_used_error_test() {
  let valid_letter = "t"
  let expected_error = validation.AlreadyUsedLetter
  let used_letters = "tes"
  let result = validation.validate_letter(valid_letter, used_letters)

  should.be_error(result)
  |> should.equal(expected_error)
}
