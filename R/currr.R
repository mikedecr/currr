
currify_verb <- function(verb) {
    function(...) {
        intention <- function(.data) {
            return(purrr::partial(verb)(.data, ...))
        }
        memoise::memoise(intention)
    }
}

`%.%` <- function(g, f) function(...) g(f(...))
`%|%` <- function(f, g) g %.% f

selecting   <- currify_verb(dplyr::select)
filtering   <- currify_verb(dplyr::filter)
grouping    <- currify_verb(dplyr::group_by)
ungrouping  <- currify_verb(dplyr::ungroup)
mutating    <- currify_verb(dplyr::mutate)
summarizing <- currify_verb(dplyr::summarize)
arranging   <- currify_verb(dplyr::arrange)
renaming    <- currify_verb(dplyr::rename)

