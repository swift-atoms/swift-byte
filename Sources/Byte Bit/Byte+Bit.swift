public import Bit_Pattern
public import Bit
public import Byte

extension Byte {

    @inlinable
    public var bits: Bit.Pattern<UInt8>.Mask {
        Bit.Pattern<UInt8>.Mask(underlying)
    }

    @inlinable
    public subscript(_ index: Int) -> Bit {
        (underlying >> UInt8(index)) & 1 == 1 ? .one : .zero
    }
}
