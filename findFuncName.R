# findFuncName

findFuncName <- function(incognito, verbose=F) {
  # Finds a function name by its value/function object through a top-to-bottom
  # search down the callstack (searchstack = rev(callstack)).
  # @param {closure} incognito Function object to get the name for
  # @param {bool} verbose Should search info be printed to the console?
  # @return {chr} Function name if match found else NULL
  searchstack <- rev(sys.parents())
  # accumulator
  g.get.out <- list()
  # default return value
  found <- NULL
  # searching
  i <- searchstack[1]
  while (i >= 0) {
    # list names in current frame
    ls.out <- ls(envir=sys.frame(i))
    # searching lazy
    if (length(ls.out) > 0) {
      # if any list values in current frame
      get.out <- mget(ls.out, envir=sys.frame(i), ifnotfound=list(NULL))
      # and reduce to match case (if any)
      cut.out <- get.out[sapply(get.out, function(o) {
        identical(paste0(deparse(incognito), collapse=''), 
                  paste0(deparse(o), collapse=''))
      })]
    }
    # conditionally logging to console
    if (verbose) {
      message('frame: ', i, '\nnames in current frame:')
      print(ls.out)
      message('match found:')
      print(if (length(ls.out) > 0 && length(cut.out) > 0) cut.out[1] else NULL)
    }
    # check if match was found in current iteration
    if (length(ls.out) > 0 && length(cut.out) > 0) {
      # returning first match within the searchstack only
      found <- names(cut.out[1])
      break
    }
    i <- i - 1
  }
  # exit
  return(found)
}

# pop this in the console::
# moo <- function() 1L
# (function() {
#   zoo <- function() 1L
#   (function() findFuncName(function() 1L, T))()
# })()