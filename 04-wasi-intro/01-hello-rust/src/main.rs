use std::io;

fn main() {
    println!("👋 hello, please type your name:");
    
    let mut user_input = String::new();
    let stdin = io::stdin();
    let _ = stdin.read_line(&mut user_input);

    println!("🤗🥰 thank you {} ", user_input);
}
