public import Bit

extension Byte {
    @inlinable
    public subscript(_ index: Int) -> Bit {
        precondition((0..<UInt8.bitWidth).contains(index), "Bit index out of bounds")
        return (underlying >> UInt8(index)) & 1 == 1 ? Bit.one : Bit.zero
    }
}
