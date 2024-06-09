package main

// hf
func main() {}

// 2- Add a reference to the host function yo
//
//export yo
func yo()

//export helloWorld
func helloWorld() {
	//fmt.Println("🎉🎉🎉🎉🎉")
	// call yo
	yo()

}
