import gleam/list
import gleam/result
import gleam/string

import simplifile

pub fn get_word() -> Result(String, simplifile.FileError) {
  let word_content_result = simplifile.read("./files/word.txt")
  let words =
    result.map(word_content_result, fn(content) {
      string.split(string.trim(content), "\n")
    })
  let shuffled_words = result.map(words, fn(words) { list.shuffle(words) })
  let random_word =
    result.try(shuffled_words, fn(words) {
      case list.first(words) {
        Ok(word) -> Ok(word)
        Error(_) -> Error(simplifile.Unknown("File with out words"))
      }
    })
  random_word
}
