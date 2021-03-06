# This file is a part of the soRvi program (http://louhos.github.com/sorvi/)

# Copyright (C) 2010-2012 Louhos <louhos.github.com>. All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#' GetMember
#' Get members of a particular council
#'
#' @param x object
#' @param name name of a person
#'
#' @return candidate object
#' 
#' @author Joona Lehtomaki \email{louhos@@googlegroups.com}
#' @export
setGeneric("GetMember", function(x, name) standardGeneric("GetMember"))

#' GetParties
#' Get Parties from Council class object
#'
#' Arguments:
#' @param x Council class object
#'
#' Returns:
#' @return parties object
#' @export
#' @references
#' See citation("sorvi") 
#' @author Joona Lehtomaki \email{louhos@@googlegroups.com}
#' @examples # 
#' @keywords utilities
setGeneric("GetParties", function(x) standardGeneric("GetParties"))
