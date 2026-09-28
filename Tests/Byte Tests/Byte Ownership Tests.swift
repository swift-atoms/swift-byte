#if Ownership
import Byte
import Testing

@Suite("Byte × Ownership.Borrow")
struct Byte_Ownership_Tests {

    @Test("Byte conforms to Ownership.Borrow.Protocol")
    func borrowProtocolConformance() {
        requireBorrowProtocol(Byte.self)
    }

    @Test("Byte's borrowed representation is a read-only span")
    func borrowedRepresentation() {
        let owner = Ownership.Unique(Byte(bitPattern: 0x2A))
        let borrowed: Byte.Borrowed = owner.span

        #expect(borrowed.count == 1)
        #expect(borrowed[0] == Byte(bitPattern: 0x2A))
    }
}

private func requireBorrowProtocol<T: Ownership.Borrow.`Protocol`>(_: T.Type) {}
#endif
