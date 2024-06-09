---
marp: true
---
# WASI Part 4: Chicory 💜 Java ☕️

## WebAssembly (Wasm), outside the browser with Wasi

---
# Wasm Plugins for Java… 

## With Chicory

![width:200px](imgs/chicory1.png)

> - https://github.com/dylibso/chicory
> - From Dylibso https://www.dylibso.com/
---
#  Zero dependencies

Chicory is a JVM native WebAssembly runtime. It allows you to run WebAssembly programs with zero native dependencies or JNI.

> Like Wazero

---
# Easy

```java
Module module = Module.builder(new File("./factorial.wasm")).build();
Instance instance = module.instantiate();

ExportFunction iterFact = instance.export("iterFact");
Value result = iterFact.apply(Value.i32(5))[0];
System.out.println("Result: " + result.asInt()); // should print 120 (5!)
```

---
# Plumbing again
> Chicory does not run Extism plug-ins
```java
Memory memory = instance.memory();
String message = "Hello, World!";
int len = message.getBytes().length;
// allocate {len} bytes of memory, this returns a pointer to that memory
int ptr = alloc.apply(Value.i32(len))[0].asInt();
// We can now write the message to the module's memory:
memory.writeString(ptr, message);
```
---
# More Plumbing!
> Decode the result
```java
int valuePosition = (int) ((result.asLong() >>> 32) & 0xFFFFFFFFL);
int valueSize = (int) (result.asLong() & 0xFFFFFFFFL);

byte[] bytes = memory.readBytes(valuePosition, valueSize);
String strResult = new String(bytes, StandardCharsets.UTF_8);
```
---
# Host functions support 😍
> This module expects an import with the name console.log
```java
var func = new HostFunction(
    (Instance instance, Value... args) -> { 
        var len = args[0].asInt();
        var offset = args[1].asInt();
        var message = instance.memory().readString(offset, len);
        println(message);
        return null;
    },
    "console",
    "log",
    List.of(ValueType.I32, ValueType.I32),
    List.of());
```

---
# Demo time! 🚀




