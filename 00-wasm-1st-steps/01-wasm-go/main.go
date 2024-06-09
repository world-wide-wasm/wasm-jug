package main

//export add
func add(x int, y int) int {
  return x + y
}

//export hello
func hello(name string) string {
  print(name)

  return "hello " + name
}


func main() {}
