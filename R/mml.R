# This file is a part of the soRvi program (http://louhos.github.com/sorvi/)

# Copyright (C) 2010-2012 Louhos <louhos.github.com>. All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


#' Preprocessing function for MML data 
#'
#' This script can be used to preprocess shape data 
#' obtained from Finnish geographical agency (Maanmittauslaitos, MML)
#' The data copyright is on (C) MML 2011.
#'
#' @aliases preprocess.shape.mml
#'
#' Arguments:
#'   @param sp Shape object (SpatialPolygonsDataFrame)
#'
#' Returns:
#'   @return Shape object (from SpatialPolygonsDataFrame class)
#'
#' @details The various Finland shape data files obtained from http://www.maanmittauslaitos.fi/aineistot-palvelut/digitaaliset-tuotteet/ilmaiset-aineistot/hankinta have been preprocessed with this function, and the preprocessed versions are included in soRvi package. You can also download shape files and apply this function.
#'
#' @export
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # load(url(paste(sorvi.data.url, "MML.rda", sep = ""))); sp <- MML[[1]][[1]]; sp2 <- PreprocessShapeMML(sp)
#' @keywords utilities

PreprocessShapeMML <- function (sp) {

  # TODO: parseri, joka poimii vain oleelliset tiedot data.frameen
  # ja tekee tarpeelliset merkistomuunnokset.
  # names(sp)
  # "Suuralue"  "Suural_ni1" "Suural_ni2" 
  # "AVI"        "AVI_ni1"    "AVI_ni2"    
  # "Maakunta"   "Maaku_ni1" "Maaku_ni2"  
  # "Seutukunta" "Seutuk_ni1" "Seutuk_ni2" 
  # "Kunta"     "Kunta_ni1"  "Kunta_ni2" 
  # "Kieli_ni1"  "Kieli_ni2"  # Ruotsi/Suomi
  # "Kaupunki"   
  # "SHAPE_Leng" "SHAPE_Area"

  # Specify fields that need to converted into UTF-8
  nams <- colnames(sp@data)
  inds <- which(nams %in% c("AVI_ni1", "AVI_ni2", "Kieli_ni1", "Kieli_ni2", "TEXT1", "TEXT2", "TEXT3", "Suural_ni1", "Suural_ni2", "Maaku_ni1",  "Maaku_ni2", "Seutuk_ni1", "Seutuk_ni2", "Kunta_ni1", "Kunta_ni2"))
  dat <- sp@data

  # Convert encoding to UTF-8 for the text fields
  dat[, inds] <- apply(sp@data[, inds], 2, function (x) {iconv(x, from = "latin1", to = "UTF-8")})

  # Convert text fields back into factors as in the original data
  for (k in inds) { dat[, k] <- factor(dat[,k]) }

  ###################################

  # The name (ni1) is always given with the main language (Kieli_ni1)
  # For compatibility with other data sources, add fields where all
  # names are systematically listed in Finnish, no matter what is the
  # main language

  if (!is.null(sp$AVI_ni1)) {
    # All ni1 already in Finnish
    dat$AVI.FI <- iconv(sp$AVI_ni1, from = "latin1", to = "UTF-8")
  }

  if (!is.null(sp$Kieli_ni1)) {
    # All ni1 already in Finnish
    dat$Kieli.FI <- dat$Kieli_ni1
  }

  if (!is.null(sp$Suural_ni1)) {
    # All ni1 already in Finnish
    dat$Suuralue.FI   <- iconv(dat$Suural_ni1, from = "latin1", to = "UTF-8") 
  }

  if (!is.null(sp$Maaku_ni1)) {
    # All ni1 already in Finnish
    dat$Maakunta.FI   <- iconv(dat$Maaku_ni1, from = "latin1", to = "UTF-8")  
  }

  if (!is.null(sp$Seutuk_ni1)) { 

    # Combine ni1, ni2 to use systematically Finnish names
    kunta <- as.character(sp$Seutuk_ni1)
    inds <- sp$Kieli_ni1 == "Ruotsi" & !sp$Seutuk_ni2 == "N_A"
    kunta[inds] <- as.character(sp$Seutuk_ni2[inds])
    dat$Seutukunta.FI <- factor(iconv(kunta, from = "latin1", to = "UTF-8"))

  }

  if (!is.null(sp$Kunta_ni1)) {
    # Combine ni1, ni2 to use systematically Finnish names
    kunta <- as.character(sp$Kunta_ni1)
    inds <- sp$Kieli_ni1 == "Ruotsi" & !sp$Kunta_ni2 == "N_A"
    kunta[inds] <- as.character(sp$Kunta_ni2[inds])
    dat$Kunta.FI <- iconv(kunta, from = "latin1", to = "UTF-8")
    
    # Update municipality names
    dat$Kunta.FI[which(dat$Kunta.FI == "Länsi-Turunmaa")] <- "Parainen"
    dat$Kunta.FI[which(dat$Kunta.FI == "Pedersöre")] <- "Pedersören kunta"

    dat$Kunta.FI <- factor(dat$Kunta.FI)

  }

  sp@data <- dat

  sp
}




#' Shows how the MML Shape files have been converted into the Rdata files included in sorvi. For detailed example, see https://github.com/louhos/sorvi/wiki/Maanmittauslaitos The various Finland shape data files obtained from http://www.maanmittauslaitos.fi/aineistot-palvelut/digitaaliset-tuotteet/ilmaiset-aineistot/hankinta have been preprocessed using this script. 
#'
#' Arguments:
#'   @param input.data.dir Directory path where the original data can be accessed. 
#'   @param verbose Print intermediate processing information
#'
#' Returns:
#'   @return Returns a list of preprocessed shape files containing the public MML data sets. 
#' 
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @export
#' @examples 
#' # MML <- GetShapeMML(data.dir = "./")
#' # save(MML, file = "MML.rda")
#' # require(tools)
#' # res <- resaveRdaFiles(MML.rda)
#' @keywords internal

GetShapeMML <- function (input.data.dir = "./", verbose = TRUE) {

  warning("GetShapeMML may crash in Windows as it uses unix commands and temporary files.")

  MML <- list()
  for (resolutions in c("1_milj_Shape_etrs_shape", "4_5_milj_shape_etrs-tm35fin")) {

    # Create temp directory for this data set and unzip 
    system(paste("mkdir ", input.data.dir, "/", resolutions, sep = ""))
    system(paste("cp ", input.data.dir, "/", resolutions, ".zip ", input.data.dir, "/", resolutions, "/", sep = ""))
    setwd(paste(input.data.dir, "/", resolutions, sep = ""))
    unzip(paste(resolutions, ".zip", sep = ""))
    setwd("../")

    temp.data.dir <- paste(input.data.dir, resolutions, "etrs-tm35fin", sep = "/")
   
    fs <- list.files(temp.data.dir, full.names = TRUE, pattern = ".shp$")

    # Ignore problematic files
    # FIXME: check these later
    remove.inds <- c()
    remove.inds <- c(remove.inds, grep("1_milj_Shape_etrs_shape/etrs-tm35fin/airport.shp", fs))
    remove.inds <- c(remove.inds, grep("1_milj_Shape_etrs_shape/etrs-tm35fin/asemat.shp", fs))
    remove.inds <- c(remove.inds, grep("1_milj_Shape_etrs_shape/etrs-tm35fin/cityp.shp", fs))
    remove.inds <- c(remove.inds, grep("1_milj_Shape_etrs_shape/etrs-tm35fin/hpoint.shp", fs))
    remove.inds <- c(remove.inds, grep("1_milj_Shape_etrs_shape/etrs-tm35fin/namep.shp", fs))
    remove.inds <- c(remove.inds, grep("1_milj_Shape_etrs_shape/etrs-tm35fin/railway.shp", fs))
    remove.inds <- c(remove.inds, grep("1_milj_Shape_etrs_shape/etrs-tm35fin/river.shp", fs))
    remove.inds <- c(remove.inds, grep("1_milj_Shape_etrs_shape/etrs-tm35fin/road.shp", fs))
    remove.inds <- c(remove.inds, grep("4_5_milj_shape_etrs-tm35fin/etrs-tm35fin/namep.shp", fs))
    remove.inds <- c(remove.inds, grep("4_5_milj_shape_etrs-tm35fin/etrs-tm35fin/railway.shp", fs))
    remove.inds <- c(remove.inds, grep("4_5_milj_shape_etrs-tm35fin/etrs-tm35fin/rajamuu.shp", fs))
    remove.inds <- c(remove.inds, grep("4_5_milj_shape_etrs-tm35fin/etrs-tm35fin/cityp.shp", fs))
    remove.inds <- c(remove.inds, grep("4_5_milj_shape_etrs-tm35fin/etrs-tm35fin/river.shp", fs))
    remove.inds <- c(remove.inds, grep("4_5_milj_shape_etrs-tm35fin/etrs-tm35fin/road.shp", fs))

    remove.inds <- c(remove.inds, grep("_l.shp", fs))

    if (length(remove.inds) > 0) {
      fs <- fs[-remove.inds]
    }      

    MML[[resolutions]] <- list()

    for (f in fs) {

      if (verbose) { message(f) }
      file.id <- unlist(strsplit(f, "/"))
      file.id <- file.id[[length(file.id)]]
      file.id <- unlist(strsplit(file.id, "\\."))[[1]]
      MML[[resolutions]][[file.id]] <- sorvi::PreprocessShapeMML(readShapePoly(f))
 
   }
    
  }

  # return the data object
  MML

}





#' Convert MML shape objects into RData format. For detailed example, see https://github.com/louhos/sorvi/wiki/Maanmittauslaitos
#'
#' Arguments:
#'   @param MML output from GetShapeMML(input.data.dir = ".")
#'   @param output.data.dir output data directory
#'
#' Returns:
#'   @return output data directory name
#'
#' @export
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # 
#' @keywords utilities

ConvertMMLToRData <- function (MML, output.data.dir = "RData/") {

  system(paste("mkdir", output.data.dir))
  for (nam in names(MML)) {
    for (item in names(MML[[nam]])) {
      message(paste(nam, item))

      sp <- MML[[nam]][[item]]    
      system(paste("mkdir ", output.data.dir, nam, sep = ""))
      fnam <- paste(output.data.dir, nam, "/", item, ".RData", sep = "")
      save(sp, file = fnam)

    }
  }

  output.data.dir

}

