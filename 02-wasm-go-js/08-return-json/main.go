package main
// json
import (
  "syscall/js"
)

// 1- Create Hello function
func Hello(this js.Value, args []js.Value) interface{} {

  // 2- get 2 arguments: firstName and lasrName
  firstName := args[0].String()
  lastName := args[1].String()

  // 3- return a map[string]interface{}
  return map[string]interface{} {
    "message": "Hello " + firstName + " " + lastName,
    "greetings":  "👋 Hey 🎉",
  }
  
}


func main() {
  // 4- "export" Hello function
  js.Global().Set("Hello", js.FuncOf(Hello))
  

  <-make(chan bool)
}

