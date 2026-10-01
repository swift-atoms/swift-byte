#if Collection
import Carrier
import Byte_Collection_Test_Support
import Collection
import Iterator
import Testing

private typealias ByteSourceIterator = Iterator.Chunk<Byte>

private struct ByteSource: Collection.`Protocol`, Sendable {
    let bytes: [Byte]

    var startIndex: Int { bytes.startIndex }

    var endIndex: Int { bytes.endIndex }

    subscript(position: Int) -> Byte { bytes[position] }

    func index(after i: Int) -> Int { bytes.index(after: i) }

    @_lifetime(borrow self)
    borrowing func makeIterator() -> ByteSourceIterator {
        ByteSourceIterator(bytes.span)
    }
}

@Suite
struct `Collection.Protocol utf8String Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Collection.Protocol utf8String Tests`.Unit {
    @Test
    func `decodes a byte-collection of "hi" to the Swift.String "hi"`() {
        let bytes: [Byte] = [Byte(bitPattern: 0x68), Byte(bitPattern: 0x69)]
        let collection = ByteSource(bytes: bytes)

        #expect(collection.utf8String == "hi")
    }

    @Test
    func `decodes a multi-byte UTF-8 collection`() {

        let bytes: [Byte] = [Byte(bitPattern: 0x41), Byte(bitPattern: 0xC3), Byte(bitPattern: 0xA9)]
        let collection = ByteSource(bytes: bytes)

        #expect(collection.utf8String == "Aé")
    }
}

extension `Collection.Protocol utf8String Tests`.`Edge Case` {
    @Test
    func `empty byte-collection decodes to the empty string`() {
        let collection = ByteSource(bytes: [])

        #expect(collection.utf8String.isEmpty)
    }
}
#endif
