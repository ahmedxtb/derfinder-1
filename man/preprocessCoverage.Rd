\name{preprocessCoverage}
\alias{preprocessCoverage}
\title{Transform and split the data}
\usage{
  preprocessCoverage(coverageInfo, cutoff = 5,
    scalefac = 32, chunksize = 5e+06, colsubset = NULL,
    verbose = FALSE)
}
\arguments{
  \item{coverageInfo}{A list containing a DataFrame
  --\code{$coverage}-- with the coverage data and a logical
  Rle --\code{$position}-- with the positions that passed
  the cutoff. This object is generated using
  \link{loadCoverage}.}

  \item{cutoff}{Per base pair, at least one sample has to
  have coverage greater than \code{cutoff} to be included
  in the result.}

  \item{colsubset}{Optional vector of column indices of
  \code{coverageInfo$coverage} that denote samples you wish
  to include in analysis.}

  \item{scalefac}{A log transformation is used on the count
  tables, so zero counts present a problem.  What number
  should we add to the entire matrix before running the
  models?}

  \item{chunksize}{How many rows of
  \code{coverageInfo$coverage} should be processed at a
  time?}

  \item{verbose}{If \code{TRUE} basic status updates will
  be printed along the way.}
}
\value{
  A list with two components. \describe{
  \item{coverageSplit }{ is a list of DataFrames. Each
  DataFrame column represents a sample and the data is
  partioned according to \code{chunksize}. The coverage
  information is scaled and log2 transformed. Note that if
  \code{colsubset} is not \code{NULL} the number of columns
  will be less than those in \code{coverageInfo$coverage}.
  The total number of rows depends on the number of base
  pairs that passed the \code{cutoff} and the information
  stored is the coverage at that given base. Further note
  that \link{filterData} is re-applied if \code{colsubset}
  is not \code{NULL} and could thus lead to fewer rows
  compared to \code{coverageInfo$coverage}. }
  \item{position }{ is a logical Rle with the positions of
  the chromosome that passed the cutoff.} }
}
\description{
  This function takes the coverage data from
  \link{loadCoverage}, scales the data, does the log2
  transformation, and splits it into appropriate chunks for
  using \link{calculateStats}.
}
\examples{
## Split the data and transform appropriately before using calculateStats()
dataReady <- preprocessCoverage(genomeData, cutoff=0, scalefac=32, chunksize=1e3, colsubset=NULL, verbose=TRUE)
names(dataReady)
dataReady
}
\author{
  Leonardo Collado-Torres
}
\seealso{
  \link{loadCoverage}, \link{calculateStats}
}
