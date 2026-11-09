import Byte
import Testing

enum `Swift.Array+Byte Tests` {}

extension `Swift.Array+Byte Tests` {
    @Suite
    struct `Byte array literals preserve UTF8 string contents` {

        @Test
        func `a string literal spells its UTF-8 bytes`() {
            let bytes: [Byte] = "OK"

            #expect(bytes == [Byte(bitPattern: 0x4F), Byte(bitPattern: 0x4B)])
        }

        @Test
        func `an empty literal is an empty array`() {
            let bytes: [Byte] = ""

            #expect(bytes.isEmpty)
        }

        @Test
        func `a literal round-trips through the UTF-8 decoding initialiser`() {
            let bytes: [Byte] = "GET / HTTP/1.1"

            #expect(String(decoding: bytes, as: UTF8.self) == "GET / HTTP/1.1")
        }
    }
}

extension `Swift.Array+Byte Tests` {
    @Suite
    struct `Byte arrays built from bit patterns keep every byte` {

        @Test
        func `contiguous bit patterns become the same bytes`() {
            let bytes = [Byte](bitPatterns: [0x4F, 0x4B] as [UInt8])

            #expect(bytes == [Byte(bitPattern: 0x4F), Byte(bitPattern: 0x4B)])
        }

        @Test
        func `non-contiguous bit patterns become the same bytes`() {
            let bytes = [Byte](bitPatterns: (0x41 as UInt8)...0x43)

            #expect(bytes == [Byte(bitPattern: 0x41), Byte(bitPattern: 0x42), Byte(bitPattern: 0x43)])
        }
    }
}
