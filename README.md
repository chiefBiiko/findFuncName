# moonwalk

Traverse the callstack in reverse order and look for identical names or values.

`findClones` and `findShadow` both take a name as input that must be defined in the same scope as the functions are called in.

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