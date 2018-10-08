//
//  Data.extension.swift
//  EonilPTYDemo
//
//  Created by Henry on 2018/10/08.
//  Copyright © 2018 Eonil. All rights reserved.
//

import Foundation

extension Data {
    func toUInt8Array() -> [UInt8] {
        let p = (self as NSData).bytes

        var bs = [] as [UInt8]
        for i in 0..<self.count {
            let dataPtr = p.advanced(by: i)
            let datum = dataPtr.load(as: UInt8.self)
            bs.append(datum)
        }

        return bs
    }
    func toString() -> String {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue)! as String
    }
    static func fromUInt8Array(_ bs:[UInt8]) -> Data {
        var r = nil as Data?
        bs.withUnsafeBufferPointer { (p:UnsafeBufferPointer<UInt8>) -> () in
            let p1 = UnsafeRawPointer(p.baseAddress)!
            let opPtr = OpaquePointer(p1)
            r = Data(bytes: UnsafePointer<UInt8>(opPtr), count: p.count)
        }
        return r!
    }

    ///    Assumes `cCharacters` is C-string.
    static func fromCCharArray(_ cCharacters:[CChar]) -> Data {
        precondition(cCharacters.count == 0 || cCharacters[(cCharacters.endIndex - 1)] == 0)
        var r = nil as Data?
        cCharacters.withUnsafeBufferPointer { (p:UnsafeBufferPointer<CChar>) -> () in
            let p1 = UnsafeRawPointer(p.baseAddress)!
            let opPtr = OpaquePointer(p1)
            r = Data(bytes: UnsafePointer<UInt8>(opPtr), count: p.count)
        }
        return r!
    }
}
