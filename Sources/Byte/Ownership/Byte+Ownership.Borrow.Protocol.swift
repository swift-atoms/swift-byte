#if Ownership
public import Ownership

extension Byte: Ownership.Borrow.`Protocol` {

    public typealias Borrowed = Swift.Span<Byte>
}
#endif
