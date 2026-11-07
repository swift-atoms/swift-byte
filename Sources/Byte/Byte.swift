public import Bit

@frozen
public struct Byte {

    @usableFromInline
    var storage: UInt8
}

extension Byte {

    @inlinable
    public init(bitPattern: UInt8) {
        self.storage = bitPattern
    }

    @inlinable
    public var bitPattern: UInt8 { storage }
}

extension Byte {

    @inlinable
    public init(repeating bit: Bit) {
        switch bit {
        case .zero: self.init(bitPattern: 0)
        case .one: self.init(bitPattern: .max)
        }
    }
}

extension Byte: Swift.Equatable {}

extension Byte: Swift.Hashable {}
