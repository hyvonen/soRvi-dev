\name{ConvertMunicipalityCodes}
\alias{ConvertMunicipalityCodes}
\title{Convert between municipality codes and names}
\usage{
  ConvertMunicipalityCodes(ids = NULL, names = NULL, MML)
}
\arguments{
  \item{ids}{NULL}

  \item{names}{NULL}

  \item{MML}{MML data, as obtained with LoadData("MML")}
}
\value{
  Depending on the input. Converted id or name vector, or
  full conversion table.
}
\description{
  Convert between municipality codes and names
}
\examples{
# LoadData("MML"); conversion.table <- ConvertMunicipalityCodes(MML = MML)
}
\author{
  Leo Lahti \email{louhos@googlegroups.com}
}
\references{
  See citation("sorvi")
}
\keyword{utilities}
