str <- c('a12! ', 'B', 'цd) he')
cut.n.check <- function(chr){
  if (nchar(chr)<=1){TRUE}
  else {
    if (substring(chr, 1, 1) == substring(chr, nchar(chr), nchar(chr))){cut.n.check(substring(chr, 2, nchar(chr)-1))}
    else {FALSE}
  }
}

is.palindrome <- function(x){
  if (typeof(x) == 'character'){
    cut.n.check(gsub("[[:punct:]]|\\d|\\s", '', tolower(paste(x, collapse=''))))
    }
}

mirror_case <- function(x){
  answ <- ''
  for (i in seq(nchar(x))) {
    sym <- substring(x, i, i)
    if (sym == toupper(sym)){answ <- paste0(answ, tolower(sym))}
    else {answ <- paste0(answ, toupper(sym))}
  }
  answ
}
