public import Byte

extension Byte: CustomStringConvertible {

    @inlinable
    public var description: String {
        underlying.description
    }
}
