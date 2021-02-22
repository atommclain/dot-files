def printSwiftError(debugger, command, result, internal_dict):
  debugger.HandleCommand("finish")
  #debugger.HandleCommand("register read")
  debugger.HandleCommand("expression -l objc -O -- long $raxAdd = $rax")
  #debugger.HandleCommand("po $raxAdd")
  debugger.HandleCommand("po unsafeBitCast(`$raxAdd`, to: Error.self)")
  #debugger.HandleCommand("continue")

def printSwiftErrorEarly(debugger, command, result, internal_dict):
  #debugger.HandleCommand("register read")
  debugger.HandleCommand("expression -l objc -O -- long $raxAdd = $rax")
  debugger.HandleCommand("expression -l objc -O -- long $rdxAdd = $rdx")
  debugger.HandleCommand("po $raxAdd")
  debugger.HandleCommand("po $rdxAdd")
  debugger.HandleCommand("po unsafeBitCast(`$raxAdd`, to: Error.self)")
  debugger.HandleCommand("po unsafeBitCast(`$rdxAdd`, to: Error.self)")
  debugger.HandleCommand("expr -l Swift -- unsafeBitCast(`$raxAdd`, to: Error.self)")
  debugger.HandleCommand("expr -l Swift -- unsafeBitCast(`$rdxAdd`, to: Error.self)")
  debugger.HandleCommand("expr -l Swift -- unsafeBitCast(`$x21`, to: Error.self)")

  #debugger.HandleCommand("continue")
  #fp frame pointer
  #lr link register
  #sp stack pointer
  #pc program counter
