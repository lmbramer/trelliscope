% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/splod.R
\name{splodPanelFn}
\alias{splodPanelFn}
\title{Default Plot Function for splod}
\usage{
splodPanelFn(df)
}
\arguments{
\item{df}{a subset of data created by \code{\link{makeSplodData}}}
}
\value{
a trellis plot object of a scatterplot for the given subset
}
\description{
Default plot function for splod
}
\examples{
\dontrun{
library(lattice)

vdbConn(tempfile(), autoYes = TRUE)

# make "splod" directly from a data frame
splod(batting, name = "batting",
  id.vars = c("playerID", "yearID", "stint", "teamID", "lgID"))

# first transform the data into a "splodDat" object
batSplodDat <- makeSplodData(batting,
  id.vars = c("playerID", "yearID", "stint", "teamID", "lgID"))
# now make "splod"
splod(batSplodDat, name = "batting2", data = batSplodDat)

# custom panel function (color by league)
mySplodFn <- function(d) {
  xyplot(jitter(y) ~ jitter(x), groups = lgID, data = d,
    xlab = getSplitVar(d, "xVar"),
    ylab = getSplitVar(d, "yVar"),
    auto.key = TRUE
  )
}

splod(batSplodDat, name = "batting3",
  data = batSplodDat, panelFn = mySplodFn)

view()
}
}
\references{
Wilkinson, L., Anushka A., and Grossman, R. L. "Graph-Theoretic Scagnostics." INFOVIS. Vol. 5. 2005.
}
\seealso{
\code{\link{splodCogFn}}, \code{\link{splod}}, \code{\link{makeSplodData}}
}
