import Bit
import Byte
import Testing

extension Byte.Test.Unit {

    @Test
    func `Byte occupies one octet`() {
        #expect(MemoryLayout<Byte>.size == 1)
        #expect(MemoryLayout<Byte>.stride == 1)
    }

    @Test
    func `typed first index reads and writes the least significant bit`() {
        var byte = Byte(repeating: .zero)

        byte[.first] = .one

        #expect(byte[.first] == .one)
        #expect(byte.bitPattern == 0b0000_0001)
    }

    @Test
    func `typed last index reads and writes the most significant bit`() {
        var byte = Byte(repeating: .zero)

        byte[.last] = .one

        #expect(byte[.last] == .one)
        #expect(byte.bitPattern == 0b1000_0000)
    }

    @Test
    func `construction consumes one Bit for each typed index`() {
        let byte = Byte { index in
            index == .first || index == .last ? .one : .zero
        }

        #expect(byte.bitPattern == 0b1000_0001)
    }

    @Test
    func `repeating construction fills all eight positions`() {
        let zero = Byte(repeating: .zero)
        let one = Byte(repeating: .one)

        #expect(zero.bitPattern == 0)
        #expect(one.bitPattern == .max)
    }
}
