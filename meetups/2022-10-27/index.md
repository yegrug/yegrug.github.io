---
title: "October 27, 2022: r2u, binary packages on Ubuntu with Dirk Eddelbuettel"
---

Dirk Eddelbuettel, maintainer of Rcpp and co-founder of the Rocker project, gave a talk about the [r2u project](https://github.com/eddelbuettel/r2u), a.k.a. how to build CRAN as Ubuntu Binaries at the October 2022 Edmonton R User Group YEGRUG meetup.

The project ties together several recent innovations, like [RSPM](https://packagemanager.rstudio.com/), [bspm](https://CRAN.R-project.org/package=bspm), to bring full integration with Ubuntu's package manager. It is fast, automated and reversible, i.e. you can upgrade Ubuntu without breaking R packages. Complete coverage for ~20k CRAN packages.

This matters not only for Linux users. Ubuntu is used as part of continuous integration pipelines, cloud servers, your Windows WSL environment, and in Docker images. Not to mention reduced CO2 emissions as a result of significantly shorter install times.

<iframe width="748" height="421" src="https://www.youtube.com/embed/fmrp7Yo5znQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Resources

- [Link to video recording](https://youtu.be/fmrp7Yo5znQ)
- [Intro slides](YEGRUG-2022-10-27.pdf)
- [r2u slides](https://dirk.eddelbuettel.com/papers/edmontonrug_oct2022_r2u.pdf)
- [r2u GitHub repository](https://github.com/eddelbuettel/r2u)
