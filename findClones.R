# findClones

findClones <- function(game) {
  # Finds an object's clones through a top-to-bottom
  # search down the callstack and matches with base::identical.
  # @param {object} game Object name to find clones for
  # @return {list} Named list
  if (!exists(deparse(substitute(game)), 
              envir=sys.frame(sys.nframe() - 1L), 
              inherits=F)) {
    stop('the given name is not bound in the current scope')
  }
  # default return value
  found <- list()
  # searching
  searchstack <- rev(sys.parents())
  # not searching in callee's scope
  i <- if (length(searchstack) > 1L) searchstack[2L] else 0L
  repeat {
    # list names in current frame
    ls.out <- ls(envir=sys.frame(i))
    # searching lazy
    if (length(ls.out) > 0L) {
      # if any list values in current frame
      get.out <- mget(ls.out, envir=sys.frame(i), ifnotfound=list(NULL))
      # and reduce to match case (if any)
      cut.out <- get.out[sapply(get.out, function(o) {
        identical(game, o)
      })]
      # append to found
      found[[paste0('frame', as.character(i))]] <- cut.out
    }
    i <- i - 1L  # moonwalking
    if (i < 0L) break  # been time
  }
  # exit
  found <- lapply(found, function(f) if (length(f) == 0L) NULL else f)
  return(found)
}
