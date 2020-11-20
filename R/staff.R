#' Staff details
#'
#' Generate an HTML file containing data on the people working in our organization.
#'
#' @param input a character string naming file which the tabular data are to be read from using
#' \code{\link[utils]{read.table}}. The following columns are mandatory: "name", "prefix", "degree",
#' "education", "interest", "email", "phone", "homepage", "lattes", and "image".
#'
#' @param output a character string naming a HTML file for writing using \code{\link[base]{writeLines}}.
#'
#' @param ... arguments to \code{\link[base]{writeLines}}.
#'
#' @export
staff <-
  function(input, output = "output.html", ...) {

    x <- utils::read.table(file = input, header = TRUE, stringsAsFactors = FALSE, ...)
    vars <- c(
      "name", "prefix", "degree", "education", "interest", "email", "phone", "homepage", "lattes", "image")
    if(!all(vars %in% colnames(x))) {
      idx <- !(vars %in% colnames(x))
      stop(paste0("missing variables: ", paste0(vars[idx], collapse = ", ")))
    }

    res <- list()
    for (i in 1:nrow(x)) {
      res[[i]] <-
        paste0(
          '<tr>',
            '<td>',
              '<img alt="', x[i, "name"], '" class="image-inline external-image" height="225" src="',
                x[i, "image"], '" title="', x[i, "name"], '" width="512"/>',
            '</td>',
            '<td>',
              '<b>', x[i, "prefix"], " ", x[i, "degree"], " ", x[i, "name"], '</b><br/>',
              x[i, "education"], '<br/>',
              '<b>Area de atuacao:</b> ', x[i, "interest"], '<br/>',
              '<b>E-mail: </b> <a class="email-link" href="mailto:', x[i, "email"],
                '?subject=Contato" target="_blank" title="">', x[i, "email"], '</a><br/>',
              '<b>phone: </b> ', x[i, "phone"], '<br/>',
              if(!is.na(x[i, "homepage"])) {
                paste('<b>Homepage: </b> <a class="external-link" href="', x[i, "homepage"],
                      '" target="_blank" title="">', x[i, "homepage"], '</a><br/>', sep = '')
              },
              '<b>Curriculo Lattes: </b> <a class="external-link" href="', x[i, "lattes"],
                '" target="_blank" title="">', x[i, "lattes"], '</a><br/>',
            '</td>',
          '</tr>'
        )
    }
    res <- paste0(res, collapse = '')
    res <- paste0('<table class="plain"><tbody>', res, '</tbody></table>', collapse = '')

    # Output
    writeLines(text = res, con = output)
  }