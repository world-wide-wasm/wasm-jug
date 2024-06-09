package garden.bots.cracker;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Future;
import io.vertx.core.Handler;
import io.vertx.core.Promise;
import io.vertx.core.buffer.Buffer;
import io.vertx.core.http.HttpMethod;
import io.vertx.ext.web.Router;

import io.vertx.ext.web.RoutingContext;
import io.vertx.ext.web.client.HttpResponse;
import io.vertx.ext.web.client.WebClient;

import org.extism.sdk.manifest.Manifest;
import org.extism.sdk.wasm.UrlWasmSource;
import org.extism.sdk.wasm.WasmSourceResolver;
import org.extism.sdk.Plugin;

import java.nio.file.Path;
import java.util.List;
import java.util.Optional;

public class MainVerticle extends AbstractVerticle {

  private Future<HttpResponse<Buffer>> downloadWasmModule(String wasmRegistryDomain, String wasmRegistryFileUri) {
    WebClient client = WebClient.create(vertx);
    return client.get(443, wasmRegistryDomain, wasmRegistryFileUri).ssl(true).send();
  }

  private Manifest loadWasmModule(String wasmFileLocalLocation) {
    // Load the WASM file
    //new Manifest(List.of(UrlWasmSource.fromUrl(wasmFileLocalLocation)));

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

        System.out.println(wasmFunctionName);

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
    var wasmRegistryDomain = Optional.ofNullable(System.getenv("WASM_REGISTRY")).orElse("");
    var wasmRegistryFileUri = Optional.ofNullable(System.getenv("WASM_URI")).orElse("");
    var wasmFileLocalLocation = Optional.ofNullable(System.getenv("WASM_FILE")).orElse("");
    var wasmFunctionName = Optional.ofNullable(System.getenv("FUNCTION_NAME")).orElse("");

    if(wasmFunctionName.isBlank()) {
      // We got a problem
      startPromise.fail(new Throwable("FAIL: Fill FUNCTION_NAME"));
    }
    if (!wasmRegistryDomain.isBlank() && wasmRegistryFileUri.isBlank()) {
      // We got a problem
      startPromise.fail(new Throwable("FAIL: Fill WASM_URI"));
    }
    if (wasmRegistryDomain.isBlank() && !wasmRegistryFileUri.isBlank()) {
      // We got a problem
      startPromise.fail(new Throwable("FAIL: Fill WASM_REGISTRY"));
    }
    if (wasmRegistryDomain.isBlank() && wasmFileLocalLocation.isBlank()) {
      // We got a problem
      startPromise.fail(new Throwable("FAIL: Fill WASM_FILE"));
    }

    //var extismContext = new Context();

    //! Load the wasm module locally;
    if (wasmRegistryDomain.isBlank()) {

      System.out.println("SUCCESS: Wasm file loaded");
      System.out.println("Wasm file: " + wasmFileLocalLocation);

      //! Load the module
      var manifest = this.loadWasmModule(wasmFileLocalLocation);

      //! Define the route handler
      var handler = this.defineHandler(manifest, wasmFunctionName);
      // This handler will be called for any POST request
      route.handler(handler);

    } else { //! Download the wasm  file from a registry
      this.downloadWasmModule(wasmRegistryDomain, wasmRegistryFileUri)
        .onFailure(err -> {
          System.out.println("FAIL: " + err.getMessage());
          startPromise.fail(new Throwable(err.getMessage()));
        })
        .onSuccess(res -> {
          //! Save the wasm file locally
          vertx.fileSystem().writeFileBlocking(wasmFileLocalLocation, res.body()); //try catch?
          System.out.println("SUCCESS: Wasm file downloaded");
          System.out.println("Wasm Registry: " + wasmRegistryDomain);
          System.out.println("Wasm file URI: " + wasmRegistryFileUri);
          System.out.println("Wasm file: " + wasmFileLocalLocation);

          //! Load the module
          var manifest = this.loadWasmModule(wasmFileLocalLocation);

          //! Define the route handler
          var handler = this.defineHandler(manifest, wasmFunctionName);
          // This handler will be called for any POST request
          route.handler(handler);
        });
    }

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
