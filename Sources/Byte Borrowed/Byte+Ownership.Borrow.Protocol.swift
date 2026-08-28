public import Byte_Protocol
public import Ownership

extension Byte: Ownership.Borrow.`Protocol` {

    public typealias Borrowed = Swift.Span<Byte>
}
