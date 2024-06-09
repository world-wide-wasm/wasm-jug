package main

import (
"unsafe"
)

// main is required for TinyGo to compile to Wasm.
func main() {}

// readBufferFromMemory (6)
// readBufferFromMemory returns a buffer from the WebAssembly memory buffer
func readBufferFromMemory(bufferPosition *uint32, length int) []byte {
  buffer := make([]byte, length)
  pointer := uintptr(unsafe.Pointer(bufferPosition))
  for i := 0; i < length; i++ {
	s := *(*int32)(unsafe.Pointer(pointer + uintptr(i)))
	buffer[i] = byte(s)
  }
  return buffer
}

// copyBufferToMemory (7)
// copyBufferToMemory copies a buffer to the WebAssembly memory buffer
func copyBufferToMemory(buffer []byte) uint64 {
  bufferPtr := &buffer[0]
  unsafePtr := uintptr(unsafe.Pointer(bufferPtr))

  pos := uint32(unsafePtr)
  size := uint32(len(buffer))

  // [shift left + or]
  //  pos                              size
  // 110101⏺000000000000000000000000⏺10110100

  return (uint64(pos) << uint64(32)) | uint64(size)
}

// helloWorld (8)
//export helloWorld
func helloWorld(bufferPosition *uint32, length int) uint64 {

  nameBytes := readBufferFromMemory(bufferPosition, length)

  message := "👋 Hello World " + string(nameBytes) + " 🌍"

  println("🩵 HEY PEOPLE 💜")

  return copyBufferToMemory([]byte(message))
}


