import Bit
import Byte
import Testing

extension Byte {
    @Suite struct `Bytes preserve all eight bits through construction and indexing` {}
}

extension Byte.`Bytes preserve all eight bits through construction and indexing` {
    @Suite struct `Byte storage construction and indexing preserve bit values` {}
    @Suite struct `No additional byte edge cases are defined` {}
    @Suite struct `Every byte pattern agrees with indexed construction` {}
}

extension Byte.`Bytes preserve all eight bits through construction and indexing`.`Byte storage construction and indexing preserve bit values` {

    @Test
    func `bit pattern round-trips`() {
        let byte = Byte(bitPattern: 0x42)
        #expect(byte.bitPattern == 0x42)
    }

    @Test
    func `equality and hashing distinguish bit patterns`() {
        #expect(Byte(bitPattern: 0x10) == Byte(bitPattern: 0x10))
        #expect(Byte(bitPattern: 0x10) != Byte(bitPattern: 0x11))
        let set: Set<Byte> = [Byte(bitPattern: 0x10), Byte(bitPattern: 0x10), Byte(bitPattern: 0x11)]
        #expect(set.count == 2)
    }
}

extension Byte.`Bytes preserve all eight bits through construction and indexing`.`Every byte pattern agrees with indexed construction` {

    @Test
    func `every bit pattern is a distinct byte`() {
        var seen: Set<Byte> = []
        for pattern in UInt8.min...UInt8.max {
            seen.insert(Byte(bitPattern: pattern))
        }
        #expect(seen.count == 256)
    }

    @Test
    func `tabulated construction and subscript agree for every byte`() {
        for pattern in UInt8.min...UInt8.max {
            let byte = Byte(bitPattern: pattern)
            let rebuilt = Byte { index in byte[index] }
            #expect(rebuilt == byte)
        }
    }
}
