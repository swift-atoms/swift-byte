public import Byte
public import Carrier

extension Byte: Carrier.`Protocol` {

    public typealias Underlying = UInt8

}
