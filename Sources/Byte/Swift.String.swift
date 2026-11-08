extension Swift.String {

    @inlinable
    public init(
        decoding bytes: some Swift.Sequence<Byte>,
        as encoding: Swift.UTF8.Type
    ) {
        self.init(decoding: bytes.lazy.map(\.bitPattern), as: encoding)
    }

    @inlinable
    public init?(
        validating bytes: some Swift.Collection<Byte>,
        as encoding: Swift.UTF8.Type
    ) {
        self.init(validating: bytes.lazy.map(\.bitPattern), as: encoding)
    }
}
