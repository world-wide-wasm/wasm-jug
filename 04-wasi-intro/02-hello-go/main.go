package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {

	fmt.Println("👋 Hello World from Go 🌍")
	args := os.Args
	argsWithoutCaller := os.Args[1:]

	fmt.Println(args)
	fmt.Println(argsWithoutCaller)

	// Create a new scanner to read from standard input
	scanner := bufio.NewScanner(os.Stdin)

	fmt.Println("Enter some text (press Ctrl+D or Ctrl+Z to end):")

	// Read input line by line
	for scanner.Scan() {
		text := scanner.Text() // Get the current line of text
		if text == "" {
			break // Exit loop if an empty line is entered
		}
		fmt.Println("You entered:", text)
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error:", err)
	}

}
