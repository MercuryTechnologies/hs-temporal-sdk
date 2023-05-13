
pub mod runtime;

#[no_mangle]
pub fn say_hello() {
    println!("Hello from Rust!");
}

#[no_mangle]
pub fn add(left: usize, right: usize) -> usize {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
