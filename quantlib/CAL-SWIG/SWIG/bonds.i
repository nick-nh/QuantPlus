/*
 Copyright (C) 2004, 2005, 2006, 2007 StatPro Italia srl
 Copyright (C) 2009 Joseph Malicki
 Copyright (C) 2011 Lluis Pujol Bajador

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

#ifndef quantlib_bonds_i
#define quantlib_bonds_i

%include instruments.i
%include calendars.i
%include daycounters.i
%include cashflows.i
%include interestrate.i
%include indexes.i

%{
using QuantLib::Bond;
using QuantLib::ZeroCouponBond;
using QuantLib::CTBZeroBond;
using QuantLib::CTBFixedBond;
using QuantLib::FixedRateBond;
using QuantLib::FloatingRateBond;
using QuantLib::PlainFloatingRateBond;
using QuantLib::AmortizingFixedRateBond;
using QuantLib::DiscountingBondEngine;

typedef boost::shared_ptr<Instrument> BondPtr;
typedef boost::shared_ptr<Instrument> ZeroCouponBondPtr;
typedef boost::shared_ptr<Instrument> CTBZeroBondPtr;
typedef boost::shared_ptr<Instrument> CTBFixedBondPtr;
typedef boost::shared_ptr<Instrument> FixedRateBondPtr;
typedef boost::shared_ptr<Instrument> FloatingRateBondPtr;
typedef boost::shared_ptr<Instrument> PlainFloatingRateBondPtr;
typedef boost::shared_ptr<Instrument> AmortizingFixedRateBondPtr;
typedef boost::shared_ptr<PricingEngine> DiscountingBondEnginePtr;
%}

%rename(Bond) BondPtr;
class BondPtr : public boost::shared_ptr<Instrument> {
    #if defined(SWIGPYTHON) || defined (SWIGRUBY)
    %rename(bondYield) yield;
    #elif defined(SWIGMZSCHEME) || defined(SWIGGUILE)
    %rename("next-coupon-rate")      nextCouponRate;
    %rename("previous-coupon-rate")  previousCouponRate;
    %rename("settlement-days")       settlementDays;
    %rename("settlement-date")       settlementDate;
    %rename("start-date")            startDate;
    %rename("maturity-date")         maturityDate;
    %rename("issue-date")            issueDate;
    %rename("clean-price")           cleanPrice;
    %rename("dirty-price")           dirtyPrice;
    %rename("settlement-value")      settlementValue;
    %rename("accrued-amount")        accruedAmount;
    #endif
	
	%feature("kwargs") BondPtr;
  public:
    %extend {
        BondPtr(Natural settlementDays,
                const Calendar& calendar,
                Real faceAmount,
                const Date& maturityDate,
                const Date& issueDate = Date(),
                const Leg& cashflows = Leg()) {
            return new BondPtr(new Bond(settlementDays,
                                        calendar,
                                        faceAmount,
                                        maturityDate,
                                        issueDate,
                                        cashflows));
        }
        // public functions
		%feature("kwargs") nextCouponRate;
        Rate nextCouponRate(const Date& d = Date()) {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->nextCouponRate(d);
        }
		%feature("kwargs") previousCouponRate;
        Rate previousCouponRate(const Date& d = Date()) {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->previousCouponRate(d);
        }
        // inspectors
        Natural settlementDays() const {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->settlementDays();
        }
		
        Date settlementDate(Date d = Date()) {
            return boost::dynamic_pointer_cast<Bond>(*self)->settlementDate(d);
        }
        Date startDate() const {
            return boost::dynamic_pointer_cast<Bond>(*self)->startDate();
        }
        Date maturityDate() const {
            return boost::dynamic_pointer_cast<Bond>(*self)->maturityDate();
        }
        Date issueDate() const {
            return boost::dynamic_pointer_cast<Bond>(*self)->issueDate();
        }
        std::vector<boost::shared_ptr<CashFlow> > cashflows() const {
            return boost::dynamic_pointer_cast<Bond>(*self)->cashflows();
        }
        std::vector<boost::shared_ptr<CashFlow> > redemptions() const {
            return boost::dynamic_pointer_cast<Bond>(*self)->redemptions();
        }
        boost::shared_ptr<CashFlow> redemption() const {
            return boost::dynamic_pointer_cast<Bond>(*self)->redemption();
        }
        Calendar calendar() const {
            return boost::dynamic_pointer_cast<Bond>(*self)->calendar();
        }
        std::vector<Real> notionals() const {
            return boost::dynamic_pointer_cast<Bond>(*self)->notionals();
        }
        Real notional(Date d = Date()) const {
            return boost::dynamic_pointer_cast<Bond>(*self)->notional(d);
        }
        // calculations
        Real cleanPrice() {
            return boost::dynamic_pointer_cast<Bond>(*self)->cleanPrice();
        }

        Real cleanPrice(Rate yield,
                        const DayCounter &dc,
                        Compounding compounding,
                        Frequency frequency,
                        const Date& settlement = Date()) {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->cleanPrice(yield,dc, compounding, frequency, settlement);
        }
        Real dirtyPrice() {
            return boost::dynamic_pointer_cast<Bond>(*self)->dirtyPrice();
        }

        Real dirtyPrice(Rate yield,
                        const DayCounter &dc,
                        Compounding compounding,
                        Frequency frequency,
                        const Date& settlement = Date()) {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->dirtyPrice(yield,dc, compounding,
                             frequency, settlement);
        }

        Real yield(const DayCounter& dc,
                   Compounding compounding,
                   Frequency freq,
                   Real accuracy = 1.0e-8,
                   Size maxEvaluations = 100) {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->yield(dc,compounding,freq,accuracy,maxEvaluations);
        }
        Real yield(Real cleanPrice,
                   const DayCounter& dc,
                   Compounding compounding,
                   Frequency freq,
                   const Date& settlement = Date(),
                   Real accuracy = 1.0e-8,
                   Size maxEvaluations = 100) {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->yield(cleanPrice,dc,compounding,freq,
                        settlement,accuracy,maxEvaluations);
        }
		%feature("kwargs") optionAdjustedSpread;
        Real optionAdjustedSpread(Real targetCleanPrice,
		                          const Handle<YieldTermStructure>& yieldCurve) {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->optionAdjustedSpread(targetCleanPrice, yieldCurve);
        }
		%feature("kwargs") accruedAmount;
        Real accruedAmount(const Date& settlement = Date()) {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->accruedAmount(settlement);
        }
        Real settlementValue() const {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->settlementValue();
        }

        Real settlementValue(Real cleanPrice) const {
            return boost::dynamic_pointer_cast<Bond>(*self)
                ->settlementValue(cleanPrice);
        }
    }
};


#if defined(SWIGMZSCHEME) || defined(SWIGGUILE)
%rename("clean-price-from-z-spread") cleanPriceFromZSpread;
%rename("dirty-price-from-z-spread") dirtyPriceFromZSpread;
#endif

%inline %{

    Real cleanPriceFromZSpread(
                   const BondPtr& bond,
                   const boost::shared_ptr<YieldTermStructure>& discountCurve,
                   Spread zSpread,
                   const DayCounter& dc,
                   Compounding compounding,
                   Frequency freq,
                   const Date& settlementDate = Date()) {
        return QuantLib::BondFunctions::cleanPrice(
                                  *(boost::dynamic_pointer_cast<Bond>(bond)),
                                  discountCurve,
                                  zSpread, dc, compounding,
                                  freq, settlementDate);
    }

%}

%rename(ZeroCouponBond) ZeroCouponBondPtr;
class ZeroCouponBondPtr : public BondPtr {
    %feature("kwargs") ZeroCouponBondPtr;
  public:
    %extend {
        ZeroCouponBondPtr(
                Natural settlementDays,
                const Calendar &calendar,
                Real faceAmount,
                const Date & maturityDate,
                BusinessDayConvention paymentConvention = QuantLib::Following,
                Real redemption = 100.0,
                const Date& issueDate = Date()) {
            return new ZeroCouponBondPtr(
                new ZeroCouponBond(settlementDays, calendar, faceAmount,
                                   maturityDate,
                                   paymentConvention, redemption,
                                   issueDate));
        }
    }
};

%rename(CTBZeroBond) CTBZeroBondPtr;
class CTBZeroBondPtr : public BondPtr {
    %feature("kwargs") CTBZeroBondPtr;
  public:
    %extend {
        CTBZeroBondPtr(
                Natural settlementDays,
                const Calendar &calendar,
                Real faceAmount,
				Real issuePrice,
				const Date& issueDate,
				const DayCounter &accrualDayCounter,
                const Date& maturityDate,
                BusinessDayConvention paymentConvention = QuantLib::Following,			
                Real redemption = 100.0) {
            return new CTBZeroBondPtr(
                new CTBZeroBond(settlementDays, calendar, faceAmount, issuePrice,  issueDate, accrualDayCounter,
                                   maturityDate,
                                   paymentConvention,
                                   redemption));
        }
		
		DayCounter dayCounter() const {
            return boost::dynamic_pointer_cast<CTBZeroBond>(*self)
                ->dayCounter();
		}

    }
};

%rename(FixedRateBond) FixedRateBondPtr;
class FixedRateBondPtr : public BondPtr {
    %feature("kwargs") FixedRateBondPtr;
  public:
    %extend {
        FixedRateBondPtr(
                Integer settlementDays,
                Real faceAmount,
                const Schedule &schedule,
                const std::vector<Rate>& coupons,
                const DayCounter& paymentDayCounter,
                BusinessDayConvention paymentConvention = QuantLib::Following,
                Real redemption = 100.0,
                Date issueDate = Date()) {
            return new FixedRateBondPtr(
                new FixedRateBond(settlementDays, faceAmount,
                                  schedule, coupons, paymentDayCounter,
                                  paymentConvention, redemption,
                                  issueDate));
        }
        Frequency frequency() const {
            return boost::dynamic_pointer_cast<FixedRateBond>(*self)
                ->frequency();
        }
        DayCounter dayCounter() const {
            return boost::dynamic_pointer_cast<FixedRateBond>(*self)
                ->dayCounter();
        }
		Real conversionFactor(Year year, Month month, Rate benchmarkRate = 0.03) const {
		
			return boost::dynamic_pointer_cast<FixedRateBond>(*self)
                ->conversionFactor(year, month, benchmarkRate);
		
		}
		Real impliedRepoRate(Date settlementDate,
							 Real futurePrice, Real cleanPrice,
							 Year year, Month month, Rate benchmarkRate = 0.03,
			                 const DayCounter& repoDayCounter = QuantLib::Actual360(), 
							 const Calendar& dayCalendar = QuantLib::China()) const {
			return boost::dynamic_pointer_cast<FixedRateBond>(*self)
                ->impliedRepoRate(settlementDate, futurePrice, cleanPrice, year, month, benchmarkRate, repoDayCounter, dayCalendar);
		
		}
		
		Real netBasis(Real futurePrice, Real cleanPrice, 
			          Year year, Month month, Rate benchmarkRate = 0.03) const {
			return boost::dynamic_pointer_cast<FixedRateBond>(*self)
                ->netBasis(futurePrice, cleanPrice, year, month, benchmarkRate); 
		}
    }
};


%rename(CTBFixedBond) CTBFixedBondPtr;
class CTBFixedBondPtr : public FixedRateBondPtr {
    %feature("kwargs") CTBFixedBondPtr;
  public:
    %extend {
        CTBFixedBondPtr(
                const Date& issueDate,
				Natural settlementDays,
				Real faceAmount,
				const Date& startDate,
				const Date& maturity,
				const Period& tenor,			   
				const std::vector<Rate>& coupons,
				const DayCounter& accrualDayCounter = QuantLib::ActualActualNoLeap(),
				bool endOfMonth = false,
				const Calendar& calendar = QuantLib::NullCalendar(),
				const Calendar& paymentCalendar = QuantLib::China(),
				BusinessDayConvention convention = QuantLib::Unadjusted,
				DateGeneration::Rule rule = QuantLib::DateGeneration::Backward,
				BusinessDayConvention paymentConvention = QuantLib::Unadjusted,
				Real redemption = 100.0,
				const Date& firstDate = Date(),
				const Date& nextToLastDate = Date()) {
            return new CTBFixedBondPtr(
                new CTBFixedBond(issueDate, settlementDays, faceAmount, startDate, maturity, tenor, 
                                 coupons, accrualDayCounter, endOfMonth,  calendar, paymentCalendar, convention, rule,
                                  paymentConvention, redemption,
                                  firstDate, nextToLastDate));
        }

    }
};

%rename(FloatingRateBond) FloatingRateBondPtr;
class FloatingRateBondPtr : public BondPtr {
    %feature("kwargs") FloatingRateBondPtr;
  public:
    %extend {
        FloatingRateBondPtr(Size settlementDays,
                            Real faceAmount,
                            const Schedule& schedule,
                            const IborIndexPtr& index,
                            const DayCounter& paymentDayCounter,
                            BusinessDayConvention paymentConvention,
                            Size fixingDays,
                            const std::vector<Real>& gearings,
                            const std::vector<Spread>& spreads,
                            const std::vector<Rate>& caps,
                            const std::vector<Rate>& floors,
                            bool inArrears,
                            Real redemption,
                            const Date& issueDate) {
            boost::shared_ptr<IborIndex> libor =
                boost::dynamic_pointer_cast<IborIndex>(index);
            return new FloatingRateBondPtr(
                new FloatingRateBond(settlementDays,
                                     faceAmount,
                                     schedule,
                                     libor,
                                     paymentDayCounter,
                                     paymentConvention,
                                     fixingDays,
                                     gearings,
                                     spreads,
                                     caps,
                                     floors,
                                     inArrears,
                                     redemption,
                                     issueDate));
        }
    }
};

%rename(PlainFloatingRateBond) PlainFloatingRateBondPtr;
class PlainFloatingRateBondPtr : public FloatingRateBondPtr {
    %feature("kwargs") PlainFloatingRateBondPtr;
  public:
    %extend {
	    PlainFloatingRateBondPtr(Natural settlementDays,
							  Real faceAmount,
			                  const Date& startDate,
			                  const Date& maturityDate,
			                  const Calendar& calendar,
			                  const IborIndexPtr& iborIndex,
			                  const DayCounter& accrualDayCounter,
			                  BusinessDayConvention accrualConvention = Following,
			                  BusinessDayConvention paymentConvention = Following) {
			boost::shared_ptr<IborIndex> libor =
                boost::dynamic_pointer_cast<IborIndex>(iborIndex);
			return new PlainFloatingRateBondPtr(
			    new PlainFloatingRateBond(settlementDays, faceAmount, startDate, 
								          maturityDate, calendar, libor, accrualDayCounter,
										  accrualConvention, paymentConvention));
		}
	}
};

#if defined(SWIGJAVA) || defined(SWIGCSHARP)
%rename(_AmortizingFixedRateBond) AmortizingFixedRateBond;
#else
%ignore AmortizingFixedRateBond;
#endif
class AmortizingFixedRateBond {
  public:
    enum AmortizingType { EqualPayment = 0, EqualPrinciple = 1 };
#if defined(SWIGJAVA) || defined(SWIGCSHARP)
  private:
    AmortizingFixedRateBond();
#endif
};

%rename(AmortizingFixedRateBond) AmortizingFixedRateBondPtr;
class AmortizingFixedRateBondPtr : public BondPtr {
  public:
  
    %extend {
	      static const AmortizingFixedRateBond::AmortizingType EqualPayment = AmortizingFixedRateBond::EqualPayment;
        static const AmortizingFixedRateBond::AmortizingType EqualPrinciple = AmortizingFixedRateBond::EqualPrinciple;

        AmortizingFixedRateBondPtr(Natural settlementDays,
                          const std::vector<Real>& notionals,
                          const Schedule& schedule,
                          const std::vector<Rate>& coupons,
                          const DayCounter& accrualDayCounter,
                          const Calendar& paymentCalendar = QuantLib::NullCalendar(),
                          BusinessDayConvention paymentConvention = Following,
                          const Date& issueDate = Date()) {
            return new AmortizingFixedRateBondPtr(
              new AmortizingFixedRateBond(settlementDays,
                                          notionals,
                                          schedule,
                                          coupons,
                                          accrualDayCounter,
                                          paymentCalendar,
                                          paymentConvention,
                                          issueDate));
        }

        AmortizingFixedRateBondPtr(Natural settlementDays,
                          const Calendar& calendar,
                          Real faceAmount,
                          const Date& startDate,
                          const Period& bondTenor,
                          const Frequency& sinkingFrequency,
                          const Rate& coupon,
                          const DayCounter& accrualDayCounter,
                          const Calendar& paymentCalendar = QuantLib::NullCalendar(),
                          BusinessDayConvention paymentConvention = Following,
			  AmortizingFixedRateBond::AmortizingType type = AmortizingFixedRateBond::EqualPayment,
                          const Date& issueDate = Date()) {
            return new AmortizingFixedRateBondPtr(
                new AmortizingFixedRateBond(settlementDays,
                                     calendar,
                                     faceAmount,
                                     startDate,
                                     bondTenor,
                                     sinkingFrequency,
                                     coupon,
                                     accrualDayCounter,
                                     paymentCalendar,
                                     paymentConvention,
									                   type,
                                     issueDate));
        }

        AmortizingFixedRateBondPtr(Natural settlementDays,
                          const Calendar& calendar,
                          Real startAmount,
                          Real endAmount,
                          const Date& startDate,
                          const Period& bondTenor,
                          const Frequency& sinkingFrequency,
                          const Rate& coupon,
                          const DayCounter& accrualDayCounter,
                          const Calendar& paymentCalendar = QuantLib::NullCalendar(),
                          BusinessDayConvention paymentConvention = Following,
		          AmortizingFixedRateBond::AmortizingType type = AmortizingFixedRateBond::EqualPayment,
                          const Date& issueDate = Date()) {
            return new AmortizingFixedRateBondPtr(
                new AmortizingFixedRateBond(settlementDays,
                                     calendar,
                                     startAmount,
                                     endAmount,
                                     startDate,
                                     bondTenor,
                                     sinkingFrequency,
                                     coupon,
                                     accrualDayCounter,
                                     paymentCalendar,
                                     paymentConvention,
									                   type,
                                     issueDate));
        }
		
    }
};

%{
using QuantLib::CmsRateBond;
typedef boost::shared_ptr<Instrument> CmsRateBondPtr;
%}

%rename(CmsRateBond) CmsRateBondPtr;
class CmsRateBondPtr : public BondPtr {
    %feature("kwargs") CmsRateBondPtr;
  public:
    %extend {
        CmsRateBondPtr(Size settlementDays,
                       Real faceAmount,
                       const Schedule& schedule,
                       const SwapIndexPtr& index,
                       const DayCounter& paymentDayCounter,
                       BusinessDayConvention paymentConvention,
                       Natural fixingDays,
                       const std::vector<Real>& gearings,
                       const std::vector<Spread>& spreads,
                       const std::vector<Rate>& caps,
                       const std::vector<Rate>& floors,
                       bool inArrears = false,
                       Real redemption = 100.0,
                       const Date& issueDate = Date()) {
            boost::shared_ptr<SwapIndex> swap =
                boost::dynamic_pointer_cast<SwapIndex>(index);
            return new CmsRateBondPtr(
                new CmsRateBond(settlementDays,
                                faceAmount,
                                schedule,
                                swap,
                                paymentDayCounter,
                                paymentConvention,
                                fixingDays,
                                gearings,
                                spreads,
                                caps,
                                floors,
                                inArrears,
                                redemption,
                                issueDate));
        }
    }
};


%rename(DiscountingBondEngine) DiscountingBondEnginePtr;
class DiscountingBondEnginePtr : public boost::shared_ptr<PricingEngine> {
  public:
    %extend {
        DiscountingBondEnginePtr(
                            const Handle<YieldTermStructure>& discountCurve) {
            return new DiscountingBondEnginePtr(
                                    new DiscountingBondEngine(discountCurve));
        }
    }
};


#endif
