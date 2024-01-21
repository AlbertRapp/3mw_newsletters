---
theme: ../theme.scss
format: 
  html: 
    fig-height: 5
    fig-dpi: 300
    fig-width: 8.88
    fig-align: center
knitr: 
  opts_chunk: 
    collapse: true
---

```{r}
setwd(here::here('NEW_DATE_HERE'))
library(tidyverse)

theme_set(
  theme_minimal(
    base_size = 16,
    base_family = 'Source Sans Pro'
  ) +
    theme(panel.grid.minor = element_blank())
) 
```

