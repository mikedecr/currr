
#' @export
currify_verb <- function(verb) {
    function(...) {
        intention <- function(.data) {
            return(purrr::partial(verb)(.data, ...))
        }
        memoise::memoise(intention)
    }
}

#' @export
`%.%` <- function(g, f) function(...) g(f(...))
#' @export
`%;%` <- function(f, g) g %.% f

selecting   <- currify_verb(dplyr::select)
#' @export
filtering   <- currify_verb(dplyr::filter)
#' @export
grouping    <- currify_verb(dplyr::group_by)
#' @export
ungrouping  <- currify_verb(dplyr::ungroup)
#' @export
mutating    <- currify_verb(dplyr::mutate)
#' @export
summarizing <- currify_verb(dplyr::summarize)
#' @export
arranging   <- currify_verb(dplyr::arrange)
#' @export
renaming    <- currify_verb(dplyr::rename)

