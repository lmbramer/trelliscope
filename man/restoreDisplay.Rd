% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/displayObj.R
\name{restoreDisplay}
\alias{restoreDisplay}
\title{Restore a Backed-Up Display Object}
\usage{
restoreDisplay(name, group = NULL, conn = getOption("vdbConn"),
  autoYes = FALSE)
}
\arguments{
\item{name}{the name of the display}

\item{group}{the group the display belongs to}

\item{conn}{VDB connection info, typically stored in options("vdbConn") at the beginning of a session, and not necessary to specify here if a valid "vdbConn" object exists}

\item{autoYes}{should questions to proceed with display removal be automatically answered with "yes"?}
}
\description{
Restore a Backed-Up Display Object
}
\examples{
library(lattice)
library(ggplot2)

d <- divide(iris, by = "Species")

# two panel functions
p1 <- function(x)
  xyplot(Sepal.Length ~ Sepal.Width, data = x)
p2 <- function(x)
  qplot(Sepal.Width, Sepal.Length, data = x)

# try them both out on a subset
p1(d[[1]]$value)
p2(d[[1]]$value)

vdbConn(tempfile(), autoYes = TRUE)

makeDisplay(d, name = "lattice", panelFn = p1)
makeDisplay(d, name = "ggplot2", panelFn = p2)

# look at a list of the displays in this vdb:
listDisplays()

# get a the lattice display object
lobj <- getDisplay("lattice")
# look at one of the fields of the display object
lobj$desc

# we forgot to provide a description in makeDisplay
# let's add one without recreating it
updateDisplay("lattice", desc = "lattice plot of sepal width vs. length")
# let's see if it was updated
lobj <- getDisplay("lattice")
lobj$desc

# overwrite one of the displays
makeDisplay(d, name = "ggplot2", panelFn = function(x) qplot(1, 1))

# notice that there is a backup display:
list.files(file.path(getVdbPath(), "displays", "common"))

# oops - let's restore the previous one
restoreDisplay(name = "ggplot2", autoYes = TRUE)

# suppose we want to get rid of the lattice display
removeDisplay("lattice", autoYes = TRUE)

# check the list of displays
listDisplays()


}
\seealso{
Other display_manipulation: \code{\link{cleanupDisplays}},
  \code{\link{getDisplay}}, \code{\link{listDisplays}},
  \code{\link{removeDisplay}}, \code{\link{updateDisplay}}
}
