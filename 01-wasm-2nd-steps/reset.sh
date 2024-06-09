#!/bin/bash

cat > ./03-wasm-go/index.html <<- EOM
<html>

<head>
  <meta charset="utf-8" />
  <link rel="stylesheet" href="my.css">

</head>

<body>
  <h1>WASM Experiments</h1>
  <h2>👋 Open the developer tools 😃</h2>
  <!-- hf -->
  <script>	
    let importObject = {
      wasi_snapshot_preview1: {
        fd_write: () => 0
      },
      // 1- add yo function
    }

    WebAssembly.instantiateStreaming(fetch("main.wasm"), importObject)
      .then(({ instance }) => {

        console.log("📦 Instance", instance)

        // Call helloWorld, helloWorld will call yo()
        instance.exports.helloWorld()

      })
      .catch(error => {
        console.log("😡 ouch", error)
      })

  </script>
</body>

</html>
EOM

cat > ./03-wasm-go/main.go <<- EOM
package main
// hf
func main() {}

// 2- Add a reference to the host function yo


//export helloWorld
func helloWorld() {

  // call yo

}
EOM

cat > ./04-wasm-go-string-param/index.html <<- EOM
<html>

<head>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="my.css">

</head>

<body>
    <h1>WASM Experiments</h1>
    <h2>👋 Open the developer tools 😃</h2>

    <script>
        
        let importObject = {
            wasi_snapshot_preview1: {
                fd_write: () => 0
            },
            env: {
                // 3- add host function
      
            }
        }


        WebAssembly.instantiateStreaming(fetch("main.wasm"), importObject)
            .then(({ instance }) => {
                // 8- make the instance global
                

                instance.exports.helloWorld()

            })
            .catch(error => {
                console.log("😡 ouch", error)
            })

    </script>
</body>

</html>
EOM


cat > ./04-wasm-go-string-param/main.go <<- EOM
package main

func main() {}

// 9- Add a reference to hostDisplay

// Display will call hostDisplay
func Display(message string) {
  // 10- Copy the message to
  // the WASM memory buffer
  // for the host

  // 11- Set the position and size
  // of the message into the shared memory

  // 12- Call the host function
  // with the position and the size
  // of the message into memory

}

//export helloWorld
func helloWorld() {

  Display("👋 Bob Morane, what's up? 🤗")

}
EOM

cat > ./05-wasm-go-the-easy-way/index.html <<- EOM
<html>

<head>
  <meta charset="utf-8" />
  <link rel="stylesheet" href="my.css">
  <!-- go -->
  <!-- 1- include go support -->
  
</head>

<body>
  <h1>WASM Experiments</h1>
  <h2>👋 Open the developer tools 😃</h2>

  <script>
    // 2- add the "Go Wasm runtime"
  
    WebAssembly.instantiateStreaming(fetch("main.wasm"), importObject)
      .then(({ instance }) => {
        // instance object contains all the Exported WebAssembly functions	

        console.log("📦 import:", importObject)
        console.log("🥚 instance:", instance)
        console.log("🪟 window:", window)

        // 3- Launch the instance

        
        // 4- Call Hello function

      })
      .catch(error => {
        console.log("😡 ouch", error)
      })

  </script>
</body>

</html>
EOM

cat > ./05-wasm-go-the-easy-way/main.go <<- EOM
package main

import (
  "fmt"
  // ! This package allows the WebAssembly program
  // ! to access the host environment (the browser)
  "syscall/js"
)

// 5- add Hello function


func main() {
  fmt.Println("👋 Hello World from GoLang 🌍")


  // 7- "export" the Hello function


  // 8- prevent to exit

}
EOM

cat > ./06-wasm-tinygo-the-easy-way/index.html <<- EOM
<html>

<head>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="my.css">
    <script src="wasm_exec.js"></script>
</head>

<body>
    <h1>WASM Experiments</h1>
    <h2>👋 Open the developer tools 😃</h2>
    <!-- tiny -->
    <script>
        const go = new Go() // Go Wasm runtime
        let importObject = go.importObject

        WebAssembly.instantiateStreaming(fetch("main.wasm"), importObject)
            .then(({ instance }) => {
                
                console.log("📦 import:", importObject)
                console.log("🥚 instance:", instance)
                console.log("🪟 window:", window)

                go.run(instance)
                
                let message = Hello("Bob Morane")

                document.querySelector("h1").innerHTML = message

            })
            .catch(error => {
                console.log("😡 ouch", error)
            })

    </script>
</body>

</html>
EOM