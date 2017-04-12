# findFuncName

Find the name of a user-defined/custom function by passing its function body to findFuncName. It does a top-to-bottom search down the callstack and if found returns the name of the function else NULL.

Useful for writing higher-order functions and figuring out whether input functions are named or anonymous.