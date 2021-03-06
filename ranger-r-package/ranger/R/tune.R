# -------------------------------------------------------------------------------
#   This file is part of Ranger.
#
# Ranger is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ranger is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ranger. If not, see <http://www.gnu.org/licenses/>.
#
# Written by:
#
#   Marvin N. Wright
# Institut fuer Medizinische Biometrie und Statistik
# Universitaet zu Luebeck
# Ratzeburger Allee 160
# 23562 Luebeck
# Germany
#
# http://www.imbs-luebeck.de
# wright@imbs.uni-luebeck.de
# -------------------------------------------------------------------------------

##' Runs ranger for a vector of \code{mtry} values and returns the out of bag prediction error for each run.
##' For each \code{mtry} the analysis will be replicated \code{n} times.
##' 
##' The runs of ranger for different values of \code{mtry} are NOT based on the same bootstrap sample. 
##' Be sure to run enough replicates (\code{n}) before you trust the results.  
##'
##' @title Tune mtry
##' @param mtry Vector of \code{mtry} values to try.
##' @param n Number of replicates.
##' @param ... Further arguments passed to Ranger.
##' @return Prediction error for each tried \code{mtry} value.
##' @seealso \code{\link{ranger}}
##' @author Marvin N. Wright
##' @export
tune.mtry <- function(mtry, n = 1, ...) {
  result <- sapply(1:n, function(x) {
    sapply(mtry, function(y) {
      rf <- ranger(mtry = y, ...)
      rf$prediction.error
    })
  })
  rownames(result) <- mtry
  return(result)
}

##' Runs ranger for a vector of \code{min.node.size} values and returns the out of bag prediction error for each run.
##' For each \code{mtry} the analysis will be replicated \code{n} times.
##'
##' The runs of ranger for different values of \code{min.node.size} are NOT based on the same bootstrap sample. 
##' Be sure to run enough replicates (\code{n}) before you trust the results.  
##' 
##' @title Tune terminal node size
##' @param min.node.size Vector of \code{min.node.size} values to try.
##' @param n Number of replicates.
##' @param ... Further arguments passed to Ranger.
##' @return Prediction error for each tried \code{min.node.size} value.
##' @seealso \code{\link{ranger}}
##' @author Marvin N. Wright
##' @export
tune.nodesize <- function(min.node.size, n = 1, ...) {
  result <- sapply(1:n, function(x) {
    sapply(min.node.size, function(y) {
      rf <- ranger(min.node.size = y, ...)
      rf$prediction.error
    })
  })
  rownames(result) <- min.node.size
  return(result)
}
