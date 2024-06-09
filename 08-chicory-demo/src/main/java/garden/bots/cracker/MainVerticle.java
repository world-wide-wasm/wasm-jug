package garden.bots.cracker;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Handler;
import io.vertx.core.Promise;
import io.vertx.core.http.HttpMethod;
import io.vertx.ext.web.Router;

import io.vertx.ext.web.RoutingContext;

import com.dylibso.chicory.runtime.ExportFunction;
import com.dylibso.chicory.wasm.types.Value;
import com.dylibso.chicory.runtime.Module;
import com.dylibso.chicory.runtime.Instance;
import com.dylibso.chicory.runtime.Memory;

import java.io.File;

import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.util.Optional;
import java.util.concurrent.locks.ReentrantLock;

public class MainVerticle extends AbstractVerticle {

  private ReentrantLock lock = new ReentrantLock();
  //private Plugin plugin;

  //? Route Handler
  private Handler<RoutingContext> defineHandler(Module module, String wasmFunctionName) {

    //! Instantiate the wasm plugin
    System.out.println("🚀 create the wasm plugin");

    Instance instance = module.instantiate();

    // automatically exported by TinyGo
    ExportFunction malloc = instance.export("malloc");
    ExportFunction free = instance.export("free");

    ExportFunction pluginFunc = instance.export(wasmFunctionName);
    Memory memory = instance.memory();

    return ctx -> {
      // curl -X POST -d 'Jane Doe' http://localhost:3000
      ctx.request().body().andThen(asyncRes -> {
        //! Get the HTTP request parameter
        var requestParameter = asyncRes.result().toString();

        lock.lock();
        try {

          int len = requestParameter.getBytes().length;
          // allocate {len} bytes of memory, this returns a pointer to that memory
          int ptr = malloc.apply(Value.i32(len))[0].asInt();
          // We can now write the message to the module's memory:
          memory.writeString(ptr, requestParameter);

          Value result = pluginFunc.apply(Value.i32(ptr), Value.i32(len))[0];
          free.apply(Value.i32(ptr), Value.i32(len));

          int valuePosition = (int) ((result.asLong() >>> 32) & 0xFFFFFFFFL);
          int valueSize = (int) (result.asLong() & 0xFFFFFFFFL);

          byte[] bytes = memory.readBytes(valuePosition, valueSize);
          String strResult = new String(bytes, StandardCharsets.UTF_8);

          //System.out.println(str);
            //! Send the response to the HTTP client
            ctx.response()
              .putHeader("content-type", "application/json; charset=utf-8")
              .end(strResult);


        } catch (Exception e) {
          ctx.response()
            .putHeader("content-type", "application/json; charset=utf-8")
            .end(e.getMessage());
        } finally {
          lock.unlock();
        }

      });
    };
  }


  @Override
  public void start(Promise<Void> startPromise) throws Exception {

    // Create a router and a POST route
    var router = Router.router(vertx);
    var route = router.route().method(HttpMethod.POST);

    //! Check environment variables

    var wasmFileLocalLocation = Optional.ofNullable(System.getenv("WASM_FILE")).orElse("");
    var wasmFunctionName = Optional.ofNullable(System.getenv("FUNCTION_NAME")).orElse("");

    if(wasmFunctionName.isBlank()) {
      // We got a problem
      startPromise.fail(new Throwable("FAIL: Fill FUNCTION_NAME"));
    }

    if (wasmFileLocalLocation.isBlank()) {
      // We got a problem
      startPromise.fail(new Throwable("FAIL: Fill WASM_FILE"));
    }


    //! Load the wasm module
    System.out.println("Wasm file: " + wasmFileLocalLocation);

    Module module = Module.builder(new File(wasmFileLocalLocation)).build();

    //! Define the route handler
    var handler = this.defineHandler(module, wasmFunctionName);
    // This handler will be called for any POST request
    route.handler(handler);

    var httpPort = Optional.ofNullable(System.getenv("HTTP_PORT")).orElse("8080");
    // Create an HTTP server
    var server = vertx.createHttpServer();

    //! Start the HTTP server
    server.requestHandler(router).listen(Integer.parseInt(httpPort), http -> {
      if (http.succeeded()) {
        startPromise.complete();
        System.out.println("Server started on port " + httpPort);
      } else {
        startPromise.fail(http.cause());
      }
    });

  }
}