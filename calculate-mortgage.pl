
#thanksgiving to our wise and beloved Holger Wache

# Calculations
# =========================================================
# Estate Price = [Estate m2] * [Estate Price per m2]

# Property Price per m3 = Property Price Assessment (Property specification)

# Property Price =[ Building m3] * [Property Price per m3]

# Outbuildings Price = [Outbuilding m3] * [Outbuilding Price per m3]

# Depreciation Rate = Depreciation Table (Age)

# Depreciation = (Building Price + Outbuilding Price) * Depreciation Rate

# Loan = Estate Price + Property Price + Outbuildings Price – Depreciation + Environment + [Correction]

# Required Mortgage = [Loan] - [Capital]

# First Mortgage = (66% of Loan) - [Security]

# Second Mortgage = 14% of [Loan]

# Total Mortgage = First Mortgage + Second Mortgage

# Mortgage Interest = 5% (First Mortgage + Second Mortgage)

# Additional Costs p.a. = 1% of Loan excl. Property Price p.a.

# Total Liabilities p.a. = Additional Costs p.a. + Mortgage Interest p.a.

# Calculatory Affordability = Total Liabilities / [Income]

# Provided Cash Ratio = Capital/Loan
# =========================================================



# Virtual API for ZEK Entries
ZEKEntry(Beatrice, Sutter).
ZEKEntry(Karin, Keller).
ZEKEntry(Peter, Meier).
ZEKEntry(Melanie, Graber).
ZEKEntry(Stephan, Ospel).
ZEKEntry(Holger, Wache).

# Virtual API for Pythagoras Entry
# Checks if a Person is in the Pythagoras list (which is not good)
pythagorasEntry(Max, Mustermann).
pythagorasEntry(Hans, Mustermann).
pythagorasEntry(Hans, Tester).
pythagorasEntry(Hans, Müller).
pythagorasEntry(Hans, Holzer).
pythagorasEntry(Rolf, Mustermann).

ProvidedCashRatio(capital, loan):- = capital/loan. 
# >40% || <=30% || >30% <=40%

CalculatoryAfforadbility(totalLiability, income X):-  X = (totalLiability/Income).

#Variante 1 mit Baum
# When a ZEK Entry exists, the mortgage is not approved
isApproved(FirstName, LastName):- isApprovedLevelPCRVariant1(), CalculatoryAfforadbility() <=0.3.
isApproved(FirstName, LastName):- isApprovedLevelPCRVariant2(), CalculatoryAfforadbility() <=0.4.
isApprovedLevelPCRVariant1(FirstName, LastName):- isApprovedLevelPYTH(FirstName, LastName), ProvidedCashRatio() >=0.2, ProvidedCashRatio() <0.3.
isApprovedLevelPCRVariant2(FirstName, LastName):- isApprovedLevelPYTH(FirstName, LastName), ProvidedCashRatio() >=0.3.
isApprovedLevelPYTH(FirstName, LastName):- isApprovedLevelZEK(), not(pythagorasEntry(FirstName, LastName)).
isApprovedLevelZEK(FirstName, LastName):- not(ZEKEntry(Firstname, LastName).

?- isApproved(FirstName, LastName).









# Alternative way for queries
# =========================================================

#Variante ausgeschrieben
# ?- isApproved(True, True, 10000, 800, PropertySpec?, 400, 32, +5, Schwiegermutter )
isApproved(FirstName, LastName, INCOME, CAPITAL, ESTATESQM, PROP_SPECS, BUILDINGSQM, PROPSQMPRICE, AGE, CORRECTION, SECURITY):- 
    not(ZEKEntry(FirstName, LastName)), not(pythagorasEntry(FirstName, LastName)), ProvidedCashRatio(CAPITAL, LOAN) < 0.2, CalculatoryAfforadbility(), CalculatoryCashRatio(). 

isApproved(FirstName, LastName, INCOME, CAPITAL, ESTATESQM, PROP_SPECS, BUILDINGSQM, PROPSQMPRICE, AGE, CORRECTION, SECURITY):- 
    not(ZEKEntry(FirstName, LastName)), not(pythagorasEntry(FirstName, LastName)), ProvidedCashRatio() >=0.2 & <0.3, CalculatoryAfforadbility(), CalculatoryCashRatio().  

#  etc.
# =========================================================
