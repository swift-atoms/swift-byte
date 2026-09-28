#if BitPattern
public import Bit_Pattern

extension Byte {
    @inlinable
    public var bits: Bit.Pattern<UInt8>.Mask {
        Bit.Pattern<UInt8>.Mask(underlying)
    }
}
#endif
