public import Byte
public import Carrier
public import Carrier_Protocol

extension Byte: Carrier.`Protocol` {

    public typealias Underlying = UInt8

}
