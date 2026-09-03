public import Byte

extension Swift.Array: @retroactive ExpressibleByUnicodeScalarLiteral,
    @retroactive ExpressibleByExtendedGraphemeClusterLiteral,
    @retroactive ExpressibleByStringLiteral
where Element == Byte {

    public typealias StringLiteralType = String

    public typealias ExtendedGraphemeClusterLiteralType = String

    public typealias UnicodeScalarLiteralType = String

    @inlinable
    public init(stringLiteral value: String) {
        self = value.utf8.map(Byte.init(bitPattern:))
    }

    @inlinable
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }

    @inlinable
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
