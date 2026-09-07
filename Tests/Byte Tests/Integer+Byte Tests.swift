import Byte
import Testing

extension Byte {
    @Suite struct `Unsigned byte conversions preserve every bit pattern` {}
}

extension Byte.`Unsigned byte conversions preserve every bit pattern` {

    @Test
    func `UInt8 initializes from the Byte bit pattern`() {
        let byte = Byte(bitPattern: 0xA5)
        #expect(UInt8(bitPattern: byte) == 0xA5)
    }

    @Test
    func `UInt8 bit-pattern conversion round-trips every byte`() {
        for pattern in UInt8.min...UInt8.max {
            let byte = Byte(bitPattern: pattern)
            #expect(UInt8(bitPattern: byte) == pattern)
        }
    }
}
