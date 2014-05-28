/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2007 Ferdinando Ametrano
 Copyright (C) 2005 Plamen Neykov
 Copyright (C) 2005, 2006, 2007 Eric Ehlers

 This file is part of QuantLib, a free-software/open-source library
 for financial quantitative analysts and developers - http://quantlib.org/

 QuantLib is free software: you can redistribute it and/or modify it
 under the terms of the QuantLib license.  You should have received a
 copy of the license along with this program; if not, please email
 <quantlib-dev@lists.sf.net>. The license is also available online at
 <http://quantlib.org/license.shtml>.

 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.  See the license for more details.
*/

/*! \file
    \brief Implementations of the utility functions defined in utilities.xml
    for use within the Addins.

    The functions implemented in this file are invoked in the Addins from code
    autogenerated by srcgen.py.
*/

#ifndef qla_utilities_hpp
#define qla_utilities_hpp

#include <string>

namespace QuantLibAddin {

/*! \ingroup utilities
    diagnostic and information functions for QuantLibAddin
*/

    //! return the version number of QuantLib
    std::string CALVersion();

    //! return the version number of QuantLibAddin (a.k.a. QuantLibObjects)
    std::string CALAddinVersion();

    //! return the version number of QuantLibXL
    std::string CALxlVersion(bool verbose = false);

}

#endif

