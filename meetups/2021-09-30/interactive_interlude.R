### 1. Microbench for performance critical code.

library(microbenchmark)

microbenchmark(
  small = sample(x = 1:10, size = 5),
  medium = sample(x = 1:10, size = 50, replace = TRUE)
)

### 2. Use argument names in function call with more than one argument.

sample(1:9, 15, TRUE)
sample(x = 1:9, size = 15, replace = TRUE)

### 3. Subset with `[[` instead of `$`.

x <- list(crowd = 10)
x$crow
x[["crow"]]
options(warnPartialMatchDollar = TRUE)
x$crow
options(warnPartialMatchDollar = NULL)
microbenchmark::microbenchmark(x$crowd, x[["crowd"]], times = 10000)

### 4. Replace `is.na` + `==` with `%in%` when operating on data frame columns.

c(NA, 2:5) == 5
c(NA, 2:5) %in% 5
y <- sample(x = c(NA, 2:5), size = 10000, replace = TRUE)
f1 <- function(x) ifelse(test = is.na(x), yes = FALSE, no = x == 5)
f2 <- function(x) x %in% 5
microbenchmark::microbenchmark(f1(y), f2(y))

### 5. Use an environment to store global variables.

store <- new.env()
store[["appstate"]] <- "working"
store[["loglevel"]] <- "info"
store[["dbpoolsize"]] <- 15
ls(envir = store)
store[["appstate"]]

### 6. Check for NA, NULL, length one all at once with `isTRUE`.

isTRUE(mtcars)
isTRUE(is.numeric(1:5))
isTRUE(NA)
isTRUE(NULL)
isTRUE(c(TRUE, TRUE))

### 7. Consider `any` and `all` on logical vectors.

x <- c(TRUE, FALSE, FALSE)
any(x)
all(x)

### 8. Know the difference between `&`/`|` and `&&`/`||`.

x && !x
x & x

### 9. You can call `names<-` and other assignment function directly.

`names<-`(x = 1:5, value = c("apple", "orange", "lemon", "grape", "banana"))
x <- list(list(a=5, b=3), list(a=4, b=6), list(a=9, b=1))
sapply(X = x, FUN = `[[`, ... = "b")

### 10. Substitute `library` with a quiet `requireNamespace`.

pkg <- "xml2"
if (!requireNamespace(package = pkg, quietly = TRUE)) {
  install.packages(pkg)
  loadNamespace(pkg)
}

### 11. Delete temporary files using `on.exit` expression.

local({
  myfile <- tempfile()
  on.exit(expr = unlink(myfile), add = TRUE)
})

### 12. Exploit attributes with `attr` and `attributes`.

dt <- mtcars
attr(x = dt, which = "source") <- "Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391–411."
attr(x = dt, which = "description") <- "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models)."
attributes(dt)

### 13. double : and triple :

plumber::
plumber:::