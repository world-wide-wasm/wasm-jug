package main

import (
  "fmt"
  // ! This package allows the WebAssembly program
  // ! to access the host environment (the browser)
  "syscall/js"
)

// 5- add Hello function
func Hello(this js.Value, args []js.Value) interface{} {
  // ! The `Hello` function takes two parameters (`this` and `args`) and returns an `interface{}` type.
  // ! The first parameter (`this`) refers to the JavaScript's global object.
  // ! The second parameter is a slice of `[]js.Value` representing
  // ! the arguments passed to the Javascript function call.

  // 6- add some code
  message := "😃 Hello " + args[0].String() // get the parameters
  fmt.Println(message)
  return message  
}



func main() {
  fmt.Println("🎃 Hello World from GoLang 🌍 [from main]")

  // 7- "export" the Hello function
  // ? Add the `Hello` function to the `global` JavaScript object,
  js.Global().Set("Hello", js.FuncOf(Hello))
  
  // 8- prevent to exit
  <-make(chan bool)
  
  // ! The Go runtime (JavaScript side) uses the wasm file as an application,
  // ! runs this application, then exits.
  // ? To tell the Go application that we don't want to exit,
  // ? we use a channel (the channel will pause the execution).
  
}
