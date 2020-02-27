# Base24

An encoder/decoder for base24 binary-to-text encoding
[Base24 encoding](https://www.kuon.ch/post/2020-02-27-base24/) for Elixir.

## Installation

The package can be installed by adding `base24` to your list of dependencies in
`mix.exs`:

```elixir
def deps do
  [
    {:base24, "~> 0.1.0"}
  ]
end
```

## Example

```elixir
val = Base24.encode24(<<0x88, 0x55, 0x33, 0x11>>)

# val is "5YEATXA"
bytes = Base24.decode24(val)

# bytes is <<0x88, 0x55, 0x33, 0x11>>
```

API documentation [https://hexdocs.pm/base24](https://hexdocs.pm/base24).

## License

Licensed under either of

 * Apache License, Version 2.0
   ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
 * MIT license
   ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.

