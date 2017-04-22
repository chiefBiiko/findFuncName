# moonwalk

Traverse the callstack in reverse order and look for identical values or names.

`findClones` and `findShadow` both take a name as input (which must be defined in the same scope as the functions are called in) and return a named list. `findClones` matches by value whereas `findShadow` matches by name.

### `findClones`

```r
saka <- 44L
(function() {
  b <- 44.
  (function() {a <- 44L; findClones(a)})()
})()
```

### `findShadow`

```r
a <- 44000L
(function() {
  waka <- 'kaka'
  (function() {a <- 44L; findShadow(a)})()
})()
```