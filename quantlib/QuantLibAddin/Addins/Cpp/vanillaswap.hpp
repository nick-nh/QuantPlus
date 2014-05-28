
/*  
 Copyright (C) 2006, 2007, 2011 Ferdinando Ametrano
 Copyright (C) 2005, 2006 Eric Ehlers
 Copyright (C) 2005 Plamen Neykov
 Copyright (C) 2005 Aurelien Chanudet
 Copyright (C) 2013 Cheng Li
 
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

// This file was generated automatically by gensrc.py.  If you edit this file
// manually then your changes will be lost the next time gensrc runs.

// This source code file was generated from the following stub:
//      gensrc/gensrc/stubs/stub.cpp.header

#ifndef qlcpp_vanillaswap_hpp
#define qlcpp_vanillaswap_hpp

#include <oh/property.hpp>
#include <string>
#include <vector>

namespace QuantLibAddinCpp {

    std::string CALIBFRSwap(
            const std::string &ObjectId,
            const ObjectHandler::property_t &PayerReceiver,
            const ObjectHandler::property_t &Nominal,
            const ObjectHandler::property_t &StartDate,
            const std::string &SwapTenor,
            const std::string &PaymentTenor,
            const ObjectHandler::property_t &FixedRate,
            const ObjectHandler::property_t &RateSpread,
            const std::string &RepoIndex,
            const ObjectHandler::property_t &Permanent,
            const ObjectHandler::property_t &Trigger,
            const bool &Overwrite);


    std::string CALMakeIMMSwap(
            const std::string &ObjectId,
            const std::string &SwapTenor,
            const std::string &IborIndex,
            const ObjectHandler::property_t &FixedRate,
            const ObjectHandler::property_t &FirstImmDate,
            const ObjectHandler::property_t &FixDayCounter,
            const ObjectHandler::property_t &Spread,
            const std::string &PricingEngineID,
            const ObjectHandler::property_t &Permanent,
            const ObjectHandler::property_t &Trigger,
            const bool &Overwrite);


    std::string CALMakeVanillaSwap(
            const std::string &ObjectId,
            const std::string &SwapTenor,
            const std::string &IborIndex,
            const ObjectHandler::property_t &FixedRate,
            const std::string &ForwardStart,
            const ObjectHandler::property_t &FixDayCounter,
            const ObjectHandler::property_t &Spread,
            const std::string &PricingEngineID,
            const ObjectHandler::property_t &Permanent,
            const ObjectHandler::property_t &Trigger,
            const bool &Overwrite);


    std::string CALShiborSwap(
            const std::string &ObjectId,
            const ObjectHandler::property_t &PayerReceiver,
            const ObjectHandler::property_t &Nominal,
            const ObjectHandler::property_t &StartDate,
            const std::string &SwapTenor,
            const std::string &FixedTenor,
            const ObjectHandler::property_t &FixedRate,
            const std::string &FloatTenor,
            const std::string &YieldCurve,
            const ObjectHandler::property_t &Permanent,
            const ObjectHandler::property_t &Trigger,
            const bool &Overwrite);


    std::string CALVanillaSwap(
            const std::string &ObjectId,
            const ObjectHandler::property_t &PayerReceiver,
            const ObjectHandler::property_t &Nominal,
            const std::string &FixSchedule,
            const ObjectHandler::property_t &FixedRate,
            const std::string &FixDayCounter,
            const std::string &FloatingLegSchedule,
            const std::string &IborIndex,
            const ObjectHandler::property_t &Spread,
            const std::string &FloatingLegDayCounter,
            const ObjectHandler::property_t &PaymentConvention,
            const ObjectHandler::property_t &Permanent,
            const ObjectHandler::property_t &Trigger,
            const bool &Overwrite);


    std::string CALVanillaSwapFromSwapIndex(
            const std::string &ObjectId,
            const std::string &SwapIndex,
            const ObjectHandler::property_t &FixingDate,
            const ObjectHandler::property_t &Permanent,
            const ObjectHandler::property_t &Trigger,
            const bool &Overwrite);


    std::string CALVanillaSwapFromSwapRateHelper(
            const std::string &ObjectId,
            const std::string &SwapRateHelper,
            const ObjectHandler::property_t &Permanent,
            const ObjectHandler::property_t &Trigger,
            const bool &Overwrite);

}

#endif

