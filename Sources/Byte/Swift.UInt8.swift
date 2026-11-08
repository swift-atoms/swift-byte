extension Swift.UInt8 {

    @inlinable
    public init(bitPattern byte: Byte) {
        self = byte.bitPattern
    }
}
