use wasm_bindgen::prelude::*;

// Called by the JS entry point to run the example
#[wasm_bindgen(start)]
pub fn run() -> Result<(), JsValue> {
    // Use web_sys's global window function to get a handle on the global
    // window object.
    let window = web_sys::window().expect("no global window exists");
    let document = window.document().expect("should have a document on window");
    let body = document.body().expect("document should have a body");

    // Manufacture the element we're gonna append
    let h1 = document.create_element("h1")?;
    h1.set_text_content(Some("👋 Hello from Rust! 🦀"));

    let h2 = document.create_element("h2")?;
    h2.set_text_content(Some("😍 I'm a subtitle"));

    body.append_child(&h1)?;
    body.append_child(&h2)?;

    Ok(())
}

