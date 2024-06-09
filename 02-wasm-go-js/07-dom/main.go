package main
// dom
import (
  // this package allows the WebAssembly program
  // to access the host environment (the browser)
  "syscall/js"
)

func main() {

  message := "👋 Hello World from TinyGo 🌍"

  // 1- reference to the DOM
  document := js.Global().Get("document")
  
  // 2- create H2 element
  h2 := document.Call("createElement", "h2")
  h2.Set("innerHTML", message)
  
  // 3- create H3 element
  h3 := document.Call("createElement", "h3")
  h3.Set("innerHTML", message)
  
  // 4- add elements to body
  document.Get("body").Call("appendChild", h2)
  document.Get("body").Call("appendChild", h3)
  
}

