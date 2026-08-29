public import Byte_Protocol
public import Carrier_Protocol
public import Ownership_Borrow

extension Byte: Ownership.Borrow.`Protocol` {

    public typealias Borrowed = Swift.Span<Byte>
}
