---
marp: true
---
# WASM Part 2

## WebAssembly (Wasm), 🐣 baby steps (today in the browser 🌍)

---

# Agenda

- Host functions?
- (Simple) Demo
- Display Host function
- "Display" Demo
- Strings and functions: the easy way 🎉
  - Demo with **GoLang**
  - Demo with **TinyGo**
---
# Btw

- No debug with WebAssembly

---

# Host functions?

- A function defined in the Host application
- Why? **you cannot do everything with WASM** 😮 *(ex: HTTP)*
- For The Wasm program, it’s used as an import function

---
# (Simple) Demo
## Call JS function from WASM
> JS calls WASM calls JS
- JavaScript side: `yo()`
- GoLang Wasm side:
  ```golang
  func helloWorld() {
    yo() // <- this is JavaScript
  }
  ```
---
# (Simple) Demo 🚀

- `03-wasm-go`

---
# (Simple) Demo 🚀

✋ *update the source code*
- Add `fmt.Println("🎉🎉🎉🎉🎉")`
- Rebuild
- Retry

---
# Display Host function

## No `Println` in Wasm 🤬
### `hostDisplay: (pos, size) => {}` callable by the Wasm module

== display text from WASM thanks to JavaScript 🤪

---
# "Display" Demo 🚀

- `04-wasm-go-string-param`

---
## You can do it with every language that targets WebAssembly

---
## But, there is an easier way 😲

---
# Strings and functions: the easy way 🎉

## Golang support of Wasm & JavaScript

### Get `wasm_exec.js`
```bash
cp "$(go env GOROOT)/misc/wasm/wasm_exec.js" .
```

### Build
```bash
GOOS=js GOARCH=wasm go build -o main.wasm
```

---
# IDE support (VSCode)

> `.vscode/settings.json`
```json
{
    "go.toolsEnvVars": {
      "GOOS": "js",
      "GOARCH": "wasm",
    },
  }
```
---
# Demo with GoLang

- `05-wasm-go-the-easy-way`

---
# Size matters

```bash
ls -lh *.wasm
-rwxr-xr-x 1 wasm wasm 2.1M Jun  3 20:33 main.wasm
```

---
# Strings and functions: the easy way 🎉

## TinyGo 🥰 support of Wasm & JavaScript

### Get `wasm_exec.js`
```bash
cp "$(tinygo env TINYGOROOT)/targets/wasm_exec.js" .
```

### Build
```bash
tinygo build --no-debug -o main.wasm -target wasm main.go
```
---
# Size matters

```bash
ls -lh *.wasm
-rwxr-xr-x 1 wasm wasm 131K Jun  8 12:57 main.wasm
```

---

# Demo with TinyGo

- `06-wasm-tinygo-the-easy-way`


---

# 📘 To read

- https://blog.suborbital.dev/foundations-wasm-in-golang-is-fantastic

---

# Next:

- Go deeper with the Wasm support with GoLang
- You can do it with Rust (or another language 🤔)
