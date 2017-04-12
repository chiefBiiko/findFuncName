#
# find a function name by value anywhere in the searchstack
findFuncName <- function(incognito) {  # incognito aka function value only
  # Finds a function name by its value/function object through a top-to-bottom
  # search down the callstack.
  callstack <- sys.parents()
  g.ls.out <- c()
  g.get.out <- list()
  for (i in rev(callstack)) {
    message('frame: ', i, '\nreturn of ls:')
    ls.out <- ls(envir=sys.frame(i))
    append(g.ls.out, ls.out)
    print(ls.out)
    message('return of get:')
    get.out <- mget(ls.out, envir=sys.frame(i), ifnotfound=list(NULL))
    append(g.get.out, get.out)
    print(get.out)
  }
  return(g.get.out)
}

# pop this in the terminal !
#(function() (function() findFuncName())())()

#> typeof(get('findfunc'))
#[1] "closure"