#if Collection
public import Carrier
import Byte_Collection_Test_Support
import Testing

extension Byte {
    @Suite struct `Collection+Byte Test` {}
}

extension Byte.`Collection+Byte Test` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
}

extension Byte.`Collection+Byte Test`.Unit {
    @Test
    func `trimming with set removes matching bytes from both ends`() {
        let bytes: [Byte] = [Byte(bitPattern: 0x20), Byte(bitPattern: 0x48), Byte(bitPattern: 0x69), Byte(bitPattern: 0x20)]
        #expect(bytes.trimming([Byte(bitPattern: 0x20)]).elementsEqual([Byte(bitPattern: 0x48), Byte(bitPattern: 0x69)]))
    }

    @Test
    func `trimming with set keeps interior matching bytes`() {
        let bytes: [Byte] = [Byte(bitPattern: 0x20), Byte(bitPattern: 0x48), Byte(bitPattern: 0x20), Byte(bitPattern: 0x69), Byte(bitPattern: 0x20)]
        #expect(bytes.trimming([Byte(bitPattern: 0x20)]).elementsEqual([Byte(bitPattern: 0x48), Byte(bitPattern: 0x20), Byte(bitPattern: 0x69)]))
    }

    @Test
    func `trimming with predicate matches set semantics`() {
        let bytes: [Byte] = [Byte(bitPattern: 0x09), Byte(bitPattern: 0x20), Byte(bitPattern: 0x46), Byte(bitPattern: 0x6F), Byte(bitPattern: 0x6F), Byte(bitPattern: 0x20), Byte(bitPattern: 0x09)]
        let lwsp: Set<Byte> = [Byte(bitPattern: 0x20), Byte(bitPattern: 0x09)]
        #expect(bytes.trimming(lwsp).elementsEqual(bytes.trimming(where: lwsp.contains)))
        #expect(bytes.trimming(lwsp).elementsEqual([Byte(bitPattern: 0x46), Byte(bitPattern: 0x6F), Byte(bitPattern: 0x6F)]))
    }
}

extension Byte.`Collection+Byte Test`.Unit {
    @Test
    func `firstIndex of byte subsequence returns matching position`() {
        let haystack: [Byte] = [Byte(bitPattern: 0x48), Byte(bitPattern: 0x65), Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6F)]
        #expect(haystack.firstIndex(of: [Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6F)]) == 3)
    }

    @Test
    func `firstIndex returns first match when multiple exist`() {
        let haystack: [Byte] = [Byte(bitPattern: 0x61), Byte(bitPattern: 0x62), Byte(bitPattern: 0x61), Byte(bitPattern: 0x62), Byte(bitPattern: 0x63)]
        #expect(haystack.firstIndex(of: [Byte(bitPattern: 0x61), Byte(bitPattern: 0x62)]) == 0)
    }

    @Test
    func `contains returns true when subsequence present`() {
        let haystack: [Byte] = [Byte(bitPattern: 0x48), Byte(bitPattern: 0x65), Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6F)]
        #expect(haystack.contains([Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6F)]))
        #expect(haystack.contains([Byte(bitPattern: 0x48)]))
    }

    @Test
    func `contains returns false when subsequence absent`() {
        let haystack: [Byte] = [Byte(bitPattern: 0x48), Byte(bitPattern: 0x65), Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6F)]
        #expect(!haystack.contains([Byte(bitPattern: 0x7A)]))
        #expect(!haystack.contains([Byte(bitPattern: 0x6C), Byte(bitPattern: 0x7A)]))
    }
}

extension Byte.`Collection+Byte Test`.`Edge Case` {
    @Test
    func `trimming empty collection yields empty subsequence`() {
        let empty: [Byte] = []
        #expect(empty.trimming([Byte(bitPattern: 0x20)]).isEmpty)
    }

    @Test
    func `trimming all-matching collection yields empty subsequence`() {
        let all: [Byte] = [Byte(bitPattern: 0x20), Byte(bitPattern: 0x20), Byte(bitPattern: 0x20)]
        #expect(all.trimming([Byte(bitPattern: 0x20)]).isEmpty)
    }

    @Test
    func `trimming with empty set is a no-op`() {
        let bytes: [Byte] = [Byte(bitPattern: 0x48), Byte(bitPattern: 0x69)]
        #expect(bytes.trimming(Set<Byte>()).elementsEqual([Byte(bitPattern: 0x48), Byte(bitPattern: 0x69)]))
    }

    @Test
    func `firstIndex of empty needle returns startIndex`() {
        let haystack: [Byte] = [Byte(bitPattern: 0x48), Byte(bitPattern: 0x69)]
        let empty: [Byte] = []
        #expect(haystack.firstIndex(of: empty) == 0)
    }

    @Test
    func `firstIndex of longer-than-haystack needle returns nil`() {
        let haystack: [Byte] = [Byte(bitPattern: 0x48)]
        #expect(haystack.firstIndex(of: [Byte(bitPattern: 0x48), Byte(bitPattern: 0x69)]) == nil)
    }

    @Test
    func `firstIndex of absent needle returns nil`() {
        let haystack: [Byte] = [Byte(bitPattern: 0x48), Byte(bitPattern: 0x65), Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6C), Byte(bitPattern: 0x6F)]
        #expect(haystack.firstIndex(of: [Byte(bitPattern: 0x77), Byte(bitPattern: 0x6F)]) == nil)
    }
}
#endif
