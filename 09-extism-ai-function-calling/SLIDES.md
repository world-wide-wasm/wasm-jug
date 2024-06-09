---
marp: true
---
# WASI Part 5: LLMs call Extism Plug-ins 

## WebAssembly (Wasm), outside the browser with Wasi

---
## Parakeet 🦜🪺
> - Little Go library to chat with Ollama 🦙
> - Parakeet4J is coming (September?)
> - TODO: Chicory + LangChain4J

---
# Function calling?

- It's not a feature where a LLM can call and execute a function
- It's the ability for certain LLMs to provide a specific output with the same format (== "a predictable output format").
---
# The principle is simple

- You will create a prompt with a delimited list of tools (the functions) composed by name, descriptions, and parameters: `SayHello`, `AddNumbers`, etc.
- Then, you will add your question (`"Hey, say 'hello' to Bob!"`) to the prompt and send all of this to the LLM.
- If the LLM "understand" that the `SayHello` function can be used to **say "hello" to Bob**, then the LLM will answer with only the name of the function with the parameter(s). For example: `{"name":"SayHello","arguments":{"name":"Bob"}}`
- And, then, you have to work a little...

---
## Why not call WASM functions?
# Demo time! 🚀
> With a LLM that does not support function calling 🤪



