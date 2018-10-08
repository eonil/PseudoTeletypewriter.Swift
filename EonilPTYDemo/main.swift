//
//  main.swift
//  EonilPTYDemo
//
//  Created by Henry on 2018/10/08.
//  Copyright © 2018 Eonil. All rights reserved.
//

import Foundation
import EonilPTY

do {
    /// Basic usage.
    let p = PseudoTeletypewriter(path: "/bin/ls", arguments: ["/bin/ls", "-Gbla"], environment: ["TERM=ansi"])!
    print(p.masterFileHandle.readDataToEndOfFile().toString())
    p.waitUntilChildProcessFinishes()
}

do {
    ///
    /// This runs infinite REPL loop.
    /// You can test this program with Xcode console.
    ///
    let pty2 = PseudoTeletypewriter(path: "/bin/bash", arguments: ["/bin/bash"], environment: ["TERM=ansi"])!
    FileHandle.standardInput.readabilityHandler = { f in
        let d = f.availableData
        pty2.masterFileHandle.write(d)
    }
    pty2.masterFileHandle.readabilityHandler = { f in
        let d = f.availableData
        let s = String(data: d, encoding: .utf8)!
        print(s)
    }
    RunLoop.main.run()
    pty2.waitUntilChildProcessFinishes()


}
