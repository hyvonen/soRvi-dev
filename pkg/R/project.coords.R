# Copyright (C) 2011 Joona Lehtomaki <joona.lehtomaki(at)gmail.com. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or
# modify it under the terms of the FreeBSD License (keep this notice):
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# This file is a part of the soRvi program
# http://sorvi.r-forge.r-project.org

#' Project a set of coordinates in a csv file from a CRS to another
#' 
#' Read in a set of coordinates from a csv file and re-project the coordintates
#' into a different CRS. Note that CRS must be known by the user. Re-prjected
#' coordinates will be output into another csv file.
#' 
#' @param csv path to the source csv file
#' @param x.field string for the field that holds the x coordinate
#' @param y.field string for the field that holds the y coordinate
#' @param from.crs CRS object for the original data
#' @param to.crs CRS object for re-projected data
#' @param filename string filename for the new csv file
#'
#' @export
#' @references
#' See citation("sorvi") 
#' @author Joona Lehtomaki \email{sorvi-commits@@lists.r-forge.r-project.org}
#' @examples # data(MML); sp <- MML[[1]][[1]]; sp2 <- PreprocessShapeMML(sp)
#' @keywords utilities, spatial, CRS


ProjectCSV <- function(csv, x.field, y.field, from.crs, to.crs, filename="") {
  
  
}


#' Utility function to  YKJ to WGS84
#'
#' Get static map from Google Maps API and convert it to ggplot2-compatible form.
#' See Terms and Conditions from http://code.google.com/apis/maps/documentation/staticmaps/index.html.
#' https://github.com/hadley/ggplot2/wiki/Crime-in-Downtown-Houston,-Texas-:-Combining-ggplot2-and-Google-Maps
#'
#' @param center Coordinates for the center of the map
#' @param zoom Zoom-level
#' @param GRAYSCALE Grayscale or colours?
#' @param scale Scale of the map, 1: less details, faster to load, 2: more details, much slower to load
#' @param maptype Type of the map
#' @param destfile Temporary file to save the obtained map picture
#' @param n_pix Size of the figure (max = 640)
#' @param format Format of the map picture (png32 is best)
#'
#' @return df Map data frame
#' 
#' @author Juuso Parkkinen \email{sorvi-commits@@lists.r-forge.r-project.org}
#' @export