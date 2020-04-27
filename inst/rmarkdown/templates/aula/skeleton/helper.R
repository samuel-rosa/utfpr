library(magrittr)
knitr::opts_chunk$set(fig.align = 'center', echo = FALSE)
img <- knitr::include_graphics
options("kableExtra.html.bsTable" = T)
tab <- 
  function (x, ...) {
    knitr::kable(x = x, format = 'html', format.args = list(decimal.mark = ','), ...) %>%
      kableExtra::kable_styling(bootstrap_options = c('striped', 'condensed', 'hover'), font_size = 22)
  }
