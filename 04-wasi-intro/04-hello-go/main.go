package main

import (
	"fmt"
	"os"
)

func main() {

	fmt.Println("👋 Hello World from Go 🌍")

	data, err := os.ReadFile("hello.txt")
	if err != nil {
		fmt.Println("😡", err)
	}

	fmt.Print(string(data))

}
