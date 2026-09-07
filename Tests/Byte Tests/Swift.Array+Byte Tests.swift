import Byte
import Testing

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
