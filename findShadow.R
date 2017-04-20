# findShadow

findShadow <- function(game) {
  # Finds an object's shadows through a top-to-bottom
  # search down the callstack and matches with base::identical.
  # @param {object} game Object name to find shadows for
  # @return {list} Named list
  if (!exists(deparse(substitute(game)), 
              envir=sys.frame(sys.nframe() - 1L), 
              inherits=F)) {
    stop('the given name is not bound in the current scope')
  }
  # search setup
  searchstack <- rev(sys.parents())
  # not searching in callee's scope
  i <- if (length(searchstack) > 1L) searchstack[2L] else 0L
  # default return value
  found <- list()
  repeat {
    ls.out <- ls(envir=sys.frame(i),  # list matching names in current frame
                 pattern=paste0('^', deparse(substitute(game)), '$'))
    if (length(ls.out) > 0L) {  # if match found
      found[[paste0('frame', as.character(i))]] <-  # append to found
        get(ls.out, envir=sys.frame(i))
    } else { 
      found[[paste0('frame', as.character(i))]] <- vector() 
    }
    i <- i - 1L  # moonwalking
    if (i < 0L) break  # been time
  }
  # exit
  found <- lapply(found, function(f) if (length(f) == 0L) NULL else f)
  return(found)
}
