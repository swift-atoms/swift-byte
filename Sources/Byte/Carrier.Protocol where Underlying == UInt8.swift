public import Carrier

extension Carrier.`Protocol` where Underlying == UInt8 {

    @inlinable
    public var byte: Byte {
        Byte(bitPattern: underlying)
    }

    @inlinable
    public init(_ byte: Byte) {
        self.init(byte.bitPattern)
    }
}
