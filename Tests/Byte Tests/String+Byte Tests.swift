import Byte
import Testing

extension Byte {
    @Suite struct `Strings decode byte sequences as UTF8` {}
}

extension Byte.`Strings decode byte sequences as UTF8` {
    @Suite struct `String decoding accepts valid UTF8 and validates invalid sequences` {}
    @Suite struct `String decoding handles invalid sequences and null bytes` {}
    @Suite struct `Byte decoding agrees with unsigned integer decoding` {}
}

extension Byte.`Strings decode byte sequences as UTF8`.`String decoding accepts valid UTF8 and validates invalid sequences` {
    @Test
    func `String decoding preserves ASCII byte contents`() {
        let bytes = [0x48, 0x69].map { Byte(bitPattern: $0) }
        #expect(String(decoding: bytes, as: UTF8.self) == "Hi")
    }

    @Test
    func `String decoding maps an empty sequence to an empty string`() {
        let bytes: [Byte] = []
        #expect(String(decoding: bytes, as: UTF8.self).isEmpty)
    }

    @Test
    func `String decoding preserves valid multibyte UTF8 contents`() {
        let bytes = [0xC3, 0xA9].map { Byte(bitPattern: $0) }
        #expect(String(decoding: bytes, as: UTF8.self) == "é")
    }

    @Test
    func `validating decode rejects invalid UTF-8`() {
        #expect(String(validating: [Byte(bitPattern: 0x80)], as: UTF8.self) == nil)
        #expect(String(validating: [Byte(bitPattern: 0x48)], as: UTF8.self) == "H")
    }
}

extension Byte.`Strings decode byte sequences as UTF8`.`String decoding handles invalid sequences and null bytes` {
    @Test
    func `invalid UTF-8 produces replacement character`() {
        #expect(String(decoding: [Byte(bitPattern: 0x80)], as: UTF8.self) == "\u{FFFD}")
    }

    @Test
    func `null byte is preserved as U+0000`() {
        #expect(String(decoding: [Byte(bitPattern: 0x00)], as: UTF8.self) == "\u{0000}")
    }
}

extension Byte.`Strings decode byte sequences as UTF8`.`Byte decoding agrees with unsigned integer decoding` {
    @Test
    func `Byte decoding matches UInt8 decoding for same bytes`() {
        let uint8s: [UInt8] = [0x48, 0x65, 0x6C, 0x6C, 0x6F]
        let bytes = uint8s.map(Byte.init(bitPattern:))

        let fromUInt8 = String(decoding: uint8s, as: UTF8.self)
        let fromByte = String(decoding: bytes, as: UTF8.self)

        #expect(fromByte == fromUInt8)
        #expect(fromByte == "Hello")
    }
}
