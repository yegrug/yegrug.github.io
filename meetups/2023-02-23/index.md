---
title: "February 23, 2023: Fast spatial analysis and kriging on grids with Dean Koch"
---

Dean Koch is an applied math graduate of the University of Alberta, now living in Vancouver BC. His PhD dissertation, on pine beetle outbreaks, began as an exploration of dynamical systems theory but took on a more statistical flavour as was drawn to practical questions of prediction (where and when will the next outbreak occur?) and inference (what is the size of the endemic population?). Dean is now in the final year of 3-year Mitacs postdoc, working (remotely) for a non-profit in Montana, the Yellowstone Ecological Research Center (YERC), and for the University of Alberta. He is currently developing an R interface and geospatial toolkit for a popular hydrological simulator from the USDA, called SWAT.

Dean presented some background about kriging, random fields, covariances, and Kronecker products, and also demoed the snapKrig R package that is fast and can handle large gridded (raster) data sets compared to some of the other packages.

<iframe width="748" height="421" src="https://www.youtube.com/embed/SqsbFe6J37E" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Resources

- [Video recording](https://youtu.be/SqsbFe6J37E)
- snapKrig on [GitHub](https://github.com/deankoch/snapKrig) and on [CRAN](https://CRAN.R-project.org/package=snapKrig)
- A good [intro paper](https://doi.org/10.1016/s0377-0427(00)00393-9) on Kronecker products by C. F. Loan
- Dean's paper on [Kronecker covariances and anisotropy](https://doi.org/10.1007/s10651-020-00456-2)
- Dean's paper on similar technique for [spatial redistribution kernels](https://doi.org/10.1098/rsif.2020.0434)
