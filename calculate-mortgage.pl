# Calculations
# =========================================================
# Estate Price = [Estate m2] * [Estate Price per m2]

# Property Price per m3 = Property Price Assessment (Property specification)

# Property Price =[ Building m3] * [Property Price per m3]

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


# Expert Knowledge // Property Price Sqm Calculation
# =========================================================



# =========================================================

# EXAMPLE QUERIES / INPUT
isApproved(FirstName, LastName, Age, Income, Capital, Loan, TotalLiability, EstateSqm, PropSpecs, BuildingSqm, PropSqmPrice, Correction, Security):- 
    isApprovedLevelPCRVariant1(FirstName, LastName, Capital, Loan), CalculatoryAfforadbility(TotalLiability, Income) <=0.3.

isApproved(FirstName, LastName, Age, Income, Capital, Loan, TotalLiability, EstateSqm, PropSpecs, BuildingSqm, PropSqmPrice, Correction, Security):- 
    isApprovedLevelPCRVariant1(FirstName, LastName, Capital, Loan), CalculatoryAfforadbility(TotalLiability, Income) <=0.4.

isApprovedLevelPCRVariant1(FirstName, LastName, Capital, Loan):- 
    isApprovedLevelPYTH(FirstName, LastName), providedCashRatio(Capital, Loan) >=0.2, ProvidedCashRatio(Capital, Loan) <0.3.

isApprovedLevelPCRVariant2(FirstName, LastName, Capital, Loan):- 
    isApprovedLevelPYTH(FirstName, LastName), providedCashRatio(Capital, Loan) >=0.3.

isApprovedLevelPYTH(FirstName, LastName):- 
    isApprovedLevelZEK(Firstname, LastName), not(pythagorasEntry(FirstName, LastName)).

isApprovedLevelZEK(FirstName, LastName):- 
    not(ZEKEntry(Firstname, LastName).

# Example Mortage Application
?- isApproved(Max, Muster, 36, 12000, 1200000, 800000, 15000, 800, 1, 300, 1000, -10000, 100000 ).


# Calculations
# =========================================================
# Estate Price = [Estate m2] * [Estate Price per m2]
estateprice(EstateSqm, EstatePriceSqm, X):- X= (EstateSqm * EstatePriceSqm)

# Property Price =[ Building m3] * [Property Price per m3]
propertyprice(  
    Propertym3, 
    Distance, 
    Nrooms, 
    RoomPriceSqm, 
    KitchenSqm, 
    KitchenpriceSqm, 
    Floors, 
    Roof, 
    BasementSqm, 
    Garage, Y):- 
        Y = Propertym3 * propertypricecalculation(
            Distance, 
            Nrooms, 
            RoomPriceSqm, 
            KitchenSqm, 
            KitchenpriceSqm, 
            Floors, 
            Roof, 
            BasementSqm, 
            Garage)

# Depreciation Rate = Depreciation Table (Age)
depreciationrate(Age,Y):- Age=<5, Y=1.
depreciationrate(Age,Y):- Age=<10, Age>5, Y=3.
depreciationrate(Age,Y):- Age=<15, Age>10, Y=7.
depreciationrate(Age,Y):- Age=<20, Age>15, Y=11.
depreciationrate(Age,Y):- Age=<25, Age>20, Y=16.
depreciationrate(Age,Y):- Age=<30, Age>25, Y=21.
depreciationrate(Age,Y):- Age=<35, Age>30, Y=26.
depreciationrate(Age,Y):- Age=<40, Age>35, Y=31.
depreciationrate(Age,Y):- Age=<45, Age>40, Y=36.
depreciationrate(Age,Y):- Age=<50, Age>45, Y=41.
depreciationrate(Age,Y):- Age=<55, Age>50, Y=46.
depreciationrate(Age,Y):- Age=<60, Age>55, Y=52.
depreciationrate(Age,Y):- Age=<65, Age>60, Y=57.
depreciationrate(Age,Y):- Age=<75, Age>65, Y=63.
depreciationrate(Age,Y):- Age=<80, Age>75, Y=68.
depreciationrate(Age,Y):- Age=<85, Age>80, Y=74.
depreciationrate(Age,Y):- Age=<90, Age>85, Y=80.
depreciationrate(Age,Y):- Age=<95, Age>90, Y=86.
depreciationrate(Age,Y):- Age>95, Y=92.

# Depreciation = (Property Price) * Depreciation Rate
depreciation(PropertyPrice,Age,Z):- depreciationrate(Age, rate), Z = PropertyPrice * Rate.

# Loan = Estate Price + Property Price  – Depreciation
loan(   EstateSqm, 
        EstatePriceSqm, 
        Distance, 
        Rooms, 
        RoomPriceSqm, 
        KitchenSqm, 
        KitchenPriceSqm, 
        Floors, 
        Roof, 
        BasementSqm, 
        Garage, 
        Age, X):- 
    U = estateprice(EstatePriceSqm, EstateSqm, U), 
    V = propertyprice(
            PropertyM3, 
            Distance, 
            Rooms, 
            RoomPriceSqm, 
            KitchenSqm, 
            KitchenPriceSqm, 
            Floors, 
            Roof, 
            BasementSqm, 
            Garage, 
            V),
    W = depreciation(Age,W), 
    X = U+V-W.

# First Mortgage = (66% of loan) - [Security]
firstMortgage(Loan,Security,X):- X = (Loan * 0.66) - Security.
# Second Mortgage = 14% of [loan]
secondMortgage(Loan,X):- X = (Loan * 0.14).
# Mortgage Interest = 5% (First Mortgage + Second Mortgage)
mortageInterest(Loan, Security):- (X = firstMortage(Loan, Security, X) + Y = secondMoartage(Loan)) * 0.05.
# Additional Costs p.a. = 1% of Loan p.a.
additionalCost(Loan,X):- X = (Loan * 0.01).
# Total Liabilities p.a. = Additional Costs p.a. + Mortgage Interest p.a.
totalLibilites(Loan, Security, Z):-  X= additionalCost(Loan, X), Y= mortageInterest(Loan, Security, Y), Z = X+Y.
# Calculatory Affordability = Total Liabilities / [Income]
calculatoryAfforadbility(Loan, Income, Z):- X = totalLibilites(Loan, X), Z= X/Income.
# Provided Cash Ratio = Capital/Loan
cashRatio(Capital,Loan, X) :- X = Capital/Loan.
# =========================================================

# Virtual API for ZEK Entries
zekEntry("Beatrice", "Sutter").
zekEntry("Karin", "Keller").
zekEntry("Peter", "Meier").
zekEntry("Melanie", "Graber").
zekEntry("Stephan", "Ospel").
zekEntry("Holger", "Wache").

# Virtual API for Pythagoras Entry
# Checks if a Person is in the Pythagoras list (which is not good)
pythagorasEntry("Max", "Muster").
pythagorasEntry("Hans", "Glauser").
pythagorasEntry("Hans", "Tester").
pythagorasEntry("Hans", "Müller").
pythagorasEntry("Hans", "Holzer").
pythagorasEntry("Rolf", "Mustermann").

providedCashRatio(Capital, Loan):- Capital/Loan. 
# >40% || <=30% || >30% <=40%

calculatoryAfforadbility(TotalLiability, Income, X):-  X = (TotalLiability/Income).

propertypricecalculation(Distance, Rooms, RoomPriceSqm, KitchenSqm, 
KitchenPriceSqm, Floors, Roof, BasementSqm, Garage, Y):- 
        pointscalculation(  
            Distance,
            Rooms,
            RoomPriceSqm,
            KitchenSqm,
            KitchenPriceSqm,
            Floors,
            Roof,
            BasementSqm,
            Garage,
            X)
        ), 
    propertysqmprice(X,Y)

pointscalculation(Distance, Rooms, RoomPriceSqm, KitchenSqm, 
KitchenPriceSqm, Floors, Roof, BasementSqm, Garage, Z):- 
    distance(Distance, N), 
    roomcount(Rooms, O),  
    roompricesqm(RoomPriceSqm, P), 
    kitchensqm(KitchenSqm,Q), 
    kitchenpricesqm(KitchenPriceSqm,R), 
    floors(Floors,S), 
    roof(Roof,T), 
    basementsqm(BasementSqm,U), 
    garage(Garage,V), 
    Z = (N+O+P+Q+R+S+T+U+V) / 9.

propertysqmprice(X,Y):- X>=1, X<2, Y=300.
propertysqmprice(X,Y):- X>=2, X<3, Y=450.
propertysqmprice(X,Y):- X>=3, X<4, Y=500.
propertysqmprice(X,Y):- X>=4, X<5, Y=550.
propertysqmprice(X,Y):- X>=5, X<6, Y=600.
propertysqmprice(X,Y):- X=6, Y=750.

distance(X,Y):- X>=0, X<5, Y=6.
distance(X,Y):- X>=6, X<10, Y=5.
distance(X,Y):- X>=10, X<20, Y=4.
distance(X,Y):- X>=20, X<30, Y=3.
distance(X,Y):- X>=30, X<40, Y=2.
distance(X,Y):- X>=40, Y=1.

rooms(X,Y):- X>=11, Y=6.
rooms(X,Y):- X>=9, X=<10, Y=5.
rooms(X,Y):- X>=7, X=<8, Y=4.
rooms(X,Y):- X>=5, X=<6, Y=3.
rooms(X,Y):- X>=3, X=<4, Y=2.
rooms(X,Y):- X=<2, Y=1.

roompricesqm(X,Y):- X>=1200, Y=6.
roompricesqm(X,Y):- X>=1000, X<1200, Y=5.
roompricesqm(X,Y):- X>=800, X<1000, Y=4.
roompricesqm(X,Y):- X>=600, X<800, Y=3.
roompricesqm(X,Y):- X>=500, X<600, Y=2.
roompricesqm(X,Y):- X<500, Y=1.

kitchensqm(X,Y):- X>=30, Y=6.
kitchensqm(X,Y):- X>=20, X<30 Y=5.
kitchensqm(X,Y):- X>=15, X<20 Y=4.
kitchensqm(X,Y):- X>=10, X<15 Y=3.
kitchensqm(X,Y):- X>=5, X<10 Y=2.
kitchensqm(X,Y):- X<5,Y=1.

kitchenpricesqm(X,Y):- X>=1600, Y=6.
kitchenpricesqm(X,Y):- X>=1400, X<1600, Y=5.
kitchenpricesqm(X,Y):- X>=1200, X<1400, Y=5.
kitchenpricesqm(X,Y):- X>=1000, X<1200, Y=5.
kitchenpricesqm(X,Y):- X>=800, X<1000, Y=5.
kitchenpricesqm(X,Y):- X<800, Y=5.

floors(X,Y):- X>=6, Y=6.
floors(X,Y):- X=5, Y=5.
floors(X,Y):- X=4, Y=4.
floors(X,Y):- X=3, Y=3.
floors(X,Y):- X=2, Y=2.
floors(X,Y):- X=1, Y=1.

roof(X,Y):- X="Mansardendach", Y=6.
roof(X,Y):- X="Satteldach", Y=5.
roof(X,Y):- X="Sheddach", Y=4.
roof(X,Y):- X="Walmdach", Y=3.
roof(X,Y):- X="Pultdach", Y=2.
roof(X,Y):- X="Flachdach", Y=1.

basementsqm(X,Y):- X>=150, Y=6.
basementsqm(X,Y):- X>=120, x<150 Y=5.
basementsqm(X,Y):- X>=100, x<120 Y=4.
basementsqm(X,Y):- X>=60, x<100 Y=3.
basementsqm(X,Y):- X>20, x<60 Y=2.
basementsqm(X,Y):- X=<20,Y=1.

garage(X,Y):- X="Tiefgarage", Y=6.
garage(X,Y):- X="Doppel", Y=5.
garage(X,Y):- X="Einzel", Y=4.
garage(X,Y):- X="Gemeinschaft", Y=4.
garage(X,Y):- X="Carport", Y=2.
garage(X,Y):- X="Nein", Y=1.
