# input processing from User

source("constant.r")

# message - character string message
# allowed_keys  - case-insensitive vector of keys to be accepted, others will be rejected 
#				- eg. c('q', 'y', 'n')
get_key <- function(message, allowed_keys) {
  if (missing(message) || length(message) == 0) {
    stop("'message' not found -  it is a mandatory parameter")
  }
  if (missing(allowed_keys) || length(allowed_keys) == 0) {
    stop("allowed keys must a non-zero length vector of character elements")
  }
  if (interactive()) {
    con <- stdin()
  } else {
    con <- "stdin"
  }
  # only accept allowed key values
  repeat {
    cat(paste0("\n>>> ", message, " > "))
    keyPressed <- tolower(readLines(con = con, n = 1, skipNul = T, encoding = "UTF-8"))

    if (keyPressed %in% allowed_keys){
      break
    }
    cat(paste0("!!!! Invalid Key - '",keyPressed, "' is not allowed. Please enter one of: '", paste0(allowed_keys, collapse="','"), "' >"))
  }
  return(keyPressed)
}
