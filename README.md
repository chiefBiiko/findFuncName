# findFuncName

Find the name of a custom in-memory and user-defined function by passing its literal function body to `findFuncName()`. It does a top-to-bottom search down the callstack and if found returns the name of the function else `NULL`.

Useful for writing higher-order functions and figuring out whether input functions are named or anonymous.

### Note

`findFuncName` moonwalks the callstack `--`. It searches for matches with its input from the function scope it was called in (frame n) down to the global scope (frame 0). As soon as it encounters a matching function object it aborts search (no more frames are scanned) and returns the name of the matched function object. Because of this lazy search behaviour having identical function objects declared in different scopes causes the most inner function object to shadow its clones in any enclosing scopes: 

```r
# pop this in the console
moo <- function() 1L    # in global env aka frame 0
(function() {           # incrementing the call stack
  zoo <- function() 1L  # zoo will shadow moo
  (function() findFuncName(function() 1L, T))()
})()
```
However, who would define the exact same function multiple times? Foo!