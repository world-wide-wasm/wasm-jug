// Package main
package main

import "unsafe"

func main() {}

// 9- Add a reference to hostDisplay
//
//export hostDisplay
func hostDisplay(pos, size uint32)

// Display will call hostDisplay
func Display(message string) {
	// 10- Copy the message to
	// the WASM memory buffer
	// for the host
	buffer := []byte(message)
	bufferPtr := &buffer[0]
	unsafePtr := uintptr(unsafe.Pointer(bufferPtr))

	// 11- Set the position and size
	// of the message into the shared memory
  pos := uint32(unsafePtr)
  size := uint32(len(buffer))
  
	// 12- Call the host function
	// with the position and the size
	// of the message into memory
  hostDisplay(pos, size)

}

//export helloWorld
func helloWorld() {

	Display("👋 Bob Morane, what's up? 🤗")
  	Display("👋 Hello World 🌍")

}
