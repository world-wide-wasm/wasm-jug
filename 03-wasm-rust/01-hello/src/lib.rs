use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn hello(name: String) -> String {
  let message = String::from("👋 hello ");
  
  return message + &name;
}
