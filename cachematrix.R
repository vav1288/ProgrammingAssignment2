## Example usage:
# > mm <- rbind(c(1,1), c(1, 2))  // Create matrix mm
# > x <- makeCacheMatrix(mm)      // Create a wrapper (with a list of 4 functions)
# > x$get()                       // Returns matrix mm
# > x$set(mm)                     // Sets another matrix, cache will be cleaned
# > cacheSolve(x)                 // Return the inverse matrix and saves it in cache
# > cacheSolve(x)                 // Second call returns inverse matrix from cache 
#                                 // it will print "getting cached data" to indicate that


## Create a wrapper around a matrix and returns a list of 4 functions to operate with the matrix:
# 1. x$get                        // returns original matrix
# 2. x$set                        // sets a new matrix (cache will be cleaned)
# 3. x$getinverse                 // returns internal variable m (this function should not be called directly)
# 4. x$setinverse                 // sets internal variable m (this function should not be called directly)
# where x is return of a function
makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinverse <- function(inv) m <<- inv
  getinverse <- function() m
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## Helper function to use cache on inverse matrix calculation
# Inverse matrix will be calculated only on first call to the function 
# All other calls will just return cached value
# The only valid x is a result of function makeCacheMatrix
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}

#style and formatting of model functions makeVector and cachemean are preserved.
