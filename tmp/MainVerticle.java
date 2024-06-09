package garden.bots.cracker;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Handler;
import io.vertx.core.Promise;
import io.vertx.core.http.HttpMethod;
import io.vertx.ext.web.Router;

import io.vertx.ext.web.RoutingContext;

import org.extism.sdk.manifest.Manifest;
import org.extism.sdk.wasm.WasmSourceResolver;
import org.extism.sdk.Plugin;

import java.nio.file.Path;
import java.util.Optional;

public class MainVerticle extends AbstractVerticle {

  private Manifest loadWasmModule(String wasmFileLocalLocation) {
    // Load the WASM file
    var resolver = new WasmSourceResolver();
    return new Manifest(resolver.resolve(Path.of(wasmFileLocalLocation)));
  }

  //? Route Handler
  private Handler<RoutingContext> defineHandler(Manifest manifest, String wasmFunctionName) {

    return ctx -> {
      // curl -X POST -d 'Jane Doe' http://localhost:3000
      ctx.request().body().andThen(asyncRes -> {
        //! Get the HTTP request parameter
        var requestParameter = asyncRes.result().toString();

        //System.out.println(wasmFunctionName);

        try {
          try (//! Instantiate the wasm plugin
          var plugin = new Plugin(manifest, true, null)) {
            //! Call the wasm function with the request parameter as argument
            var output = plugin.call(wasmFunctionName, requestParameter);

            //! Send the response to the HTTP client
            ctx.response()
              .putHeader("content-type", "application/json; charset=utf-8")
              .end(output);
          }

        } catch (Exception e) {
          ctx.response()
            .putHeader("content-type", "application/json; charset=utf-8")
            .end(e.getMessage());
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
    var manifest = this.loadWasmModule(wasmFileLocalLocation);

    //! Define the route handler
    var handler = this.defineHandler(manifest, wasmFunctionName);
    // This handler will be called for any POST request
    route.handler(handler);

    var httpPort = Optional.ofNullable(System.getenv("HTTP_PORT")).orElse("8080");
    // Create an HTTP server
    var server = vertx.createHttpServer();

    //! Start the HTTP server
    server.requestHandler(router).listen(Integer.parseInt(httpPort), http -> {
      if (http.succeeded()) {
        startPromise.complete();
        System.out.println("Cracker 0.0.3 [Sprites launcher] server started on port " + httpPort);
      } else {
        startPromise.fail(http.cause());
      }
    });

  }
}
