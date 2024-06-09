package main

import (
	"github.com/extism/go-pdk"
)

//export helloWorld
func helloWorld() int32 {
	
	// Read the memory
	input := pdk.Input()

	output := `{"message":"👋 Hello World 🌍 from Go","input": "` + string(input) + `"}`

	mem := pdk.AllocateString(output)
	
	// copy the data to the memory
	pdk.OutputMemory(mem)

	return 0
}

func main() {}
