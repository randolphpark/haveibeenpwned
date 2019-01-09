#[macro_use] extern crate rustler;
#[macro_use] extern crate rustler_codegen;
#[macro_use] extern crate lazy_static;
#[macro_use] extern crate haveibeenpwned;

use rustler::{Env, Term, NifResult, Encoder};

mod atoms {
    rustler_atoms! {
        atom ok;
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler_export_nifs! {
    "Elixir.Nifread",
    [("password_pwned", 1, password_pwned)],
    None
}

fn password_pwned<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let sha: Vec<u8> = try!(args[0].decode());
    let result = haveibeenpwned::check_pwned(from_slice(&sha));
    Ok(result.encode(env))
}

fn from_slice(bytes: &[u8]) -> [u8; 10] {
    let mut array = [0; 10];
    let bytes = &bytes[..array.len()]; // panics if not enough data
    array.copy_from_slice(bytes);
    array
}