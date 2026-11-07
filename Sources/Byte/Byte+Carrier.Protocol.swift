public import Carrier

extension Byte: Carrier.`Protocol` {

    public typealias Underlying = UInt8

    @inlinable
    public var underlying: UInt8 { bitPattern }

    @inlinable
    public init(_ underlying: consuming UInt8) {
        self.init(bitPattern: underlying)
    }
}
