## This function takes an inversible matrix as input and creates
## a list with 4 elements to "get" and "set" the value of the matrix
## and its inverse
## It is run by assigning it to a variable, which can later be
## passed to cacheSolve.

makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinv <- function(inv) i <<- inv
  getinv <- function() i
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}


## This function takes an argument of type "makeCacheMatrix",
## checks to see if the passed matrix has had its inverse cached,
## and returns it if so. If not, it calculates the inverse.

cacheSolve <- function(x, ...) {
  i <- x$getinv()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinv(i)
  i
}
