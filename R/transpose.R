#' Transpose a list.
#'
#' Tranpose turns a list-of-lists "inside-out"; it turns a pair of lists into a
#' list of pairs, or a list of pairs into pair of lists. For example,
#' If you had a list of length n where each component had values `a` and
#' `b`, `transpose()` would make a list with elements `a` and
#' `b` that contained lists of length n. It's called transpose because
#' \code{x[[1]][[2]]} is equivalent to \code{transpose(x)[[2]][[1]]}.
#'
#' Note that `transpose()` is its own inverse, much like the
#' transpose operation on a matrix. You can get back the original
#' input by transposing it twice.
#'
#' @param .l A list of vectors to zip. The first element is used as the
#'   template; you'll get a warning if a sub-list is not the same length as
#'   the first element.
#' @param .names For efficiency, `transpose()` usually inspects the
#'   first component of `.l` to determine the structure. Use `.names`
#'   if you want to override this default.
#' @return A list with indexing transposed compared to `.l`.
#' @export
#' @examples
#' x <- rerun(5, x = runif(1), y = runif(5))
#' x %>% str()
#' x %>% transpose() %>% str()
#' # Back to where we started
#' x %>% transpose() %>% transpose() %>% str()
#'
#' # transpose() is useful in conjunction with safely() & quietly()
#' x <- list("a", 1, 2)
#' y <- x %>% map(safely(log))
#' y %>% str()
#' y %>% transpose() %>% str()
#'
#' # Use simplify_all() to reduce to atomic vectors where possible
#' x <- list(list(a = 1, b = 2), list(a = 3, b = 4), list(a = 5, b = 6))
#' x %>% transpose()
#' x %>% transpose() %>% simplify_all()
#' @useDynLib purrr transpose_impl
transpose <- function(.l, .names = NULL) {
  .Call(transpose_impl, .l, .names)
}

#' @rdname transpose
#' @export
#' @usage NULL
zip_n <- function(...) {
  warning("`zip_n()` is deprecated; please use `transpose()` instead.",
    call. = FALSE)
  transpose(...)
}

#' @rdname transpose
#' @export
#' @usage NULL
zip2 <- function(.x, .y, .fields = NULL) {
  warning(
    "`zip2(x, y)` is deprecated, please use `transpose(list(x, y))` instead.",
    call. = FALSE
  )
  transpose(list(.x, .y))
}

#' @rdname transpose
#' @export
#' @usage NULL
zip3 <- function(.x, .y, .z, .fields = NULL) {
  warning(
    "`zip2(x, y, z)` is deprecated, please use `transpose(list(x, y, z))` instead.",
    call. = FALSE
  )

  transpose(list(.x, .y, .z))
}
