package main
// func
import (
  "fmt"
  "syscall/js"
)

func main() {
  // 1- Call the JavaScript function
  value := js.Global().Call("sayHello", "Bill")
  fmt.Println("🟪", value)
  
  // 2- Get the value of the JavaScript variable (message)
  message := js.Global().Get("message").String()
  fmt.Println("🟪", "message (before):", message)
  
  // 3- Change the message
  js.Global().Set("message", "🟪 🚀 this is a message from TinyGo")
  
  // 4- Get Human information
  human := js.Global().Get("human")
  fmt.Println("🟪", human)
  fmt.Println("🟪", "human age:", human.Get("age"))
  
  // 5- Change Human properties
  human.Set("firstName", "Bob")
  human.Set("lastName", "Morane")
  
  <-make(chan bool)
}

