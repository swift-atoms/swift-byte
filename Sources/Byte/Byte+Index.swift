public import Bit
public import Index
public import Finite
public import Ordinal
public import Tagged

extension Byte {

    @inlinable
    public init(
        _ bit: (Index<Bit>.Bounded<8>) -> Bit
    ) {
        self.init(repeating: .zero)
        for position in 0..<8 {
            let index = Self.index(position)
            self[index] = bit(index)
        }
    }
}

extension Byte {

    @inlinable
    public subscript(
        _ index: Index<Bit>.Bounded<8>
    ) -> Bit {
        get {
            let position = UInt8(index.underlying.underlying.rawValue)
            return storage &>> position & 1 == 0 ? .zero : .one
        }
        set {
            let position = UInt8(index.underlying.underlying.rawValue)
            let mask: UInt8 = 1 &<< position
            switch newValue {
            case .zero: storage &= ~mask
            case .one: storage |= mask
            }
        }
    }
}

extension Tagged where Tag == Bit, Underlying == Ordinal.Finite<8> {

    @inlinable
    public static var first: Self {
        Self(_unchecked: Ordinal.Finite<8>(_unchecked: 0))
    }

    @inlinable
    public static var last: Self {
        Self(_unchecked: Ordinal.Finite<8>(_unchecked: 7))
    }
}

extension Byte {
    @usableFromInline
    static func index(
        _ position: Int
    ) -> Index<Bit>.Bounded<8> {
        Index<Bit>.Bounded<8>(
            _unchecked: Ordinal.Finite<8>(_unchecked: position)
        )
    }
}
