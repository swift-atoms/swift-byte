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

extension Byte {
    @inlinable
    public subscript(_ index: Int) -> Bit {
        precondition((0..<UInt8.bitWidth).contains(index), "Bit index out of bounds")
        return (underlying >> UInt8(index)) & 1 == 1 ? Bit.one : Bit.zero
    }
}

#if BitPattern
    public import Bit_Pattern

    extension Byte {
        @inlinable
        public var bits: Bit.Pattern<UInt8>.Mask {
            Bit.Pattern<UInt8>.Mask(underlying)
        }
    }
#endif
