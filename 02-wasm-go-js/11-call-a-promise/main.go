package main
// prom
import (
    "fmt"
    "syscall/js"
)

func main() {

    // 1- if everything goes well
    thenFunc :=
        func(this js.Value, args []js.Value) interface{} {
            fmt.Println("🎉 All good:", args[0].String())
            return ""
        }
    
    // 2- catch the error
    catchFunc :=
        func(this js.Value, args []js.Value) interface{} {
            fmt.Println("😡 Ouch:", args[0].Get("message"))
            return ""
        }
    
    // 3- it's a success
    js.Global().Call("compute", false).Call("then", js.FuncOf(thenFunc)).Call("catch", js.FuncOf(catchFunc))
    
    
    // 4- it's a fail
    js.Global().Call("compute", true).Call("then", js.FuncOf(thenFunc)).Call("catch", js.FuncOf(catchFunc))
    

    <-make(chan bool)
}

