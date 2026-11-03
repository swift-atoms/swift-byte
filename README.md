# swift-byte

Use this package when a value is an octet of data rather than a small number: wire formats, parsers and buffers that should not admit integer arithmetic by accident. Start from `Byte`, which wraps a `UInt8` bit pattern and addresses its eight bits as `Bit` values through `Index<Bit>.Bounded<8>`. For bitwise masks and population counts over the same octet, enable the `BitPattern` trait and use `bits`, a `Bit.Pattern<UInt8>.Mask` from swift-bit-pattern; to give your own `UInt8`-backed type the same conversions, conform it to `Carrier.Protocol`.

## Laws

- Bit positions count from the least significant bit: position 0 and `.first` are the 2⁰ bit, position 7 and `.last` are the 2⁷ bit. Reading every position and rebuilding the `Byte` from them returns the original for all 256 bit patterns.
- Two `Byte` values are equal exactly when their bit patterns are equal; every one of the 256 patterns is a distinct value.
- A `[Byte]` or `Swift.ArraySlice<Byte>` string literal holds the UTF-8 encoding of the literal, byte for byte.
- `String(decoding:as:)` over `Byte` values never fails: each ill-formed UTF-8 sequence becomes U+FFFD, and a zero byte stays U+0000. `String(validating:as:)` returns `nil` on any ill-formed sequence instead. `utf8String` decodes the same way as `String(decoding:as:)`.
- Under the `Ownership` trait, the borrowed form of a `Byte` is a one-element `Swift.Span<Byte>`.
- Under the `Collection` trait, `trimming` removes matching elements from both ends only and keeps matches in the interior; an empty set trims nothing, and a collection that matches entirely trims to an empty subsequence. `firstIndex(of:)` finds the leftmost occurrence of a subsequence, returns `startIndex` for an empty needle, and returns `nil` when the needle is longer than the collection.
