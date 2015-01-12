Eonil/PseudoTeletypewriter.Swift
================================
Hoon H.


Simple `pty` on Swift.

Here's quick example.

	let	pty	=	PseudoTeletypewriter(path: "/bin/ls", arguments: ["/bin/ls", "-Gbla"], environment: ["TERM=ansi"])!
	println(pty.masterFileHandle.readDataToEndOfFile().toString())
	pty.waitUntilChildProcessFinishes()






License
-------
This project is licensed under MIT license.