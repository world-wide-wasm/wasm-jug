package main

import (
	"fmt"
	"syscall/js"
)

func Hello(this js.Value, args []js.Value) interface{} {
	message := "😃 Hello " + args[0].String() // get the parameters
	fmt.Println(message)
	return message
}

func main() {
	fmt.Println("👋 Hello World from 🎃 TinyGo 🌍")

	js.Global().Set("Hello", js.FuncOf(Hello))

	<-make(chan bool)

}
