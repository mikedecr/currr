
#' Create a curryable verb.
#'
#' currify_verb(foo) creates a function of dots (...).
#' Passing arguments to this function in turn creates a new function foo(.data, ...)
#' @param verb A function that takes .data and args (...)
#' @examples
#' filtering = currify_verb(dplyr::filter)
#' @export
currify_verb <- function(verb) {
    function(...) {
        intention <- function(.data) {
            return(purrr::partial(verb)(.data, ...))
        }
        memoise::memoise(intention)
    }
}

#' Function composition operator.
#'
#' `g %.% f` creates a function equivalent to g(f(x)) for some input `x`.
#' Meant to emulate infix notation for function composition, $f . g$.
#' @param g A function
#' @param f A function
#' @examples
#' (length %.% unique)(c(1, 1, 2, 2, 3))
#' @export
`%.%` <- function(g, f) function(...) g(f(...))

#' Postfix function composition operator.
#'
#' `f %;% g` creates a function equivalent to g(f(x)) (or `x |> f() |> g()`) for some input `x`.
#' Unlike conventional function composition, which evaluates right to left, postfix notation operates left to right.
#' This is similar to the direction of the pipe operator `|>`, except the postfix operator creates a function (without evaluating it).
#' @param f A function
#' @param g A function
#' @examples
#' (unique %;% length)(c(1, 1, 2, 2, 3))
#' @export
`%;%` <- function(f, g) g %.% f

#' Curryable dplyr::select.
#'
#' Pass all arguments except .data to create a new function of .data.
#' @export
selecting   <- currify_verb(dplyr::select)

#' Curryable dplyr::filter
#'
#' Pass all arguments except .data to create a new function of .data.
#' @export
filtering   <- currify_verb(dplyr::filter)

#' Curryable dplyr::group_by
#'
#' Pass all arguments except .data to create a new function of .data.
#' @export
grouping    <- currify_verb(dplyr::group_by)

#' Curryable dplyr::ungroup
#'
#' Pass all arguments except .data to create a new function of .data.
#' @export
ungrouping  <- currify_verb(dplyr::ungroup)

#' Curryable dplyr::mutate
#'
#' Pass all arguments except .data to create a new function of .data.
#' @export
mutating    <- currify_verb(dplyr::mutate)

#' Curryable dplyr::summarize
#'
#' Pass all arguments except .data to create a new function of .data.
#' @export
summarizing <- currify_verb(dplyr::summarize)

#' Curryable dplyr::arrange
#'
#' Pass all arguments except .data to create a new function of .data.
#' @export
arranging   <- currify_verb(dplyr::arrange)

#' Curryable dplyr::rename
#'
#' Pass all arguments except .data to create a new function of .data.
#' @export
renaming    <- currify_verb(dplyr::rename)

