% Calculations
% =========================================================
% Estate Price = [Estate m2] * [Estate Price per m2]

% Property Price per m3 = Property Price Assessment (Property specification)

% Property Price =[ Building m3] * [Property Price per m3]

% Depreciation Rate = Depreciation Table (PropertyAge)

% Depreciation = (Building Price + Outbuilding Price) * Depreciation Rate

% Loan = Estate Price + Property Price + Outbuildings Price – Depreciation + Environment + [Correction]

% Required Mortgage = [Loan] - [Capital]

% First Mortgage = (66% of Loan) - [Security]

% Second Mortgage = 14% of [Loan]

% Total Mortgage = First Mortgage + Second Mortgage

% Mortgage Interest = 5% (First Mortgage + Second Mortgage)

% Additional Costs p.a. = 1% of Loan excl. Property Price p.a.

% Total Liabilities p.a. = Additional Costs p.a. + Mortgage Interest p.a.

% Calculatory Affordability = Total Liabilities / [Income]

% Provided Cash Ratio = Capital/Loan
% =========================================================


========================================================= SUCCESS ======================================

% Example Mortage Application
isApproved("Holger", "Wache", 20, 300000, 50000, 150000, 500, 1000, 200, 10, 5 , 200, 20, 200, 3, "Sheddach", 200, "Doppel" ).
% Add more examples here

% INPUT - Example Queries

isApproved(FirstName, LastName, PropertyAge, Income, Capital, Security, EstateSqm, EstatePriceSqm, PropertyM3, Distance, Rooms, RoomPriceSqm, KitchenSqm, KitchenPriceSqm, Floors, Roof, BasementSqm, Garage):- 
    loan(EstateSqm, EstatePriceSqm, Distance, PropertyM3, Rooms, RoomPriceSqm, KitchenSqm, KitchenPriceSqm, Floors, Roof, BasementSqm, Garage,PropertyAge, X), 
    isApprovedLevelPCRVariant1(FirstName, LastName, Capital, X), 
    calculatoryAfforadbility(X, Income, Security, Z),
    Z=<0.3.

isApproved(FirstName, LastName, PropertyAge, Income, Capital, Security, EstateSqm, EstatePriceSqm, PropertyM3, Distance, Rooms, RoomPriceSqm, KitchenSqm, KitchenPriceSqm, Floors, Roof, BasementSqm, Garage):- 
    loan(EstateSqm, EstatePriceSqm, Distance, PropertyM3, Rooms, RoomPriceSqm, KitchenSqm, KitchenPriceSqm, Floors, Roof, BasementSqm, Garage,PropertyAge, X), 
    isApprovedLevelPCRVariant2(FirstName, LastName, Capital, X), 
    calculatoryAfforadbility(X, Income, Security, Z),
    Z=<0.4.

isApprovedLevelPCRVariant1(FirstName, LastName, Capital, Loan):- 
    isApprovedLevelPYTH(FirstName, LastName), providedCashRatio(Capital, Loan, X),
    X >=0.2, providedCashRatio(Capital, Loan, Z),
    Z <0.3.

isApprovedLevelPCRVariant2(FirstName, LastName, Capital, Loan):- 
    isApprovedLevelPYTH(FirstName, LastName), providedCashRatio(Capital, Loan, X),
    X >=0.3.
isApprovedLevelPYTH(FirstName, LastName):- 
    isApprovedLevelZEK(FirstName, LastName), not(pythagorasEntry(FirstName, LastName)).

isApprovedLevelZEK(FirstName, LastName):- 
    not(zekEntry(FirstName, LastName)).


% Calculations
% =========================================================
% Estate Price = [Estate m2] * [Estate Price per m2]
estateprice(EstateSqm, EstatePriceSqm, X):- X is EstateSqm * EstatePriceSqm.

% Property Price =[ Building m3] * [Property Price per m3]
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
    propertypricecalculation(
            Distance, 
            Nrooms, 
            RoomPriceSqm, 
            KitchenSqm, 
            KitchenpriceSqm, 
            Floors, 
            Roof, 
            BasementSqm, 
            Garage,
        	X),
        Y is Propertym3 * X.

% Depreciation Rate = Depreciation Table (PropertyAge)
depreciationrate(PropertyAge,Y):- PropertyAge=<5, Y=1.
depreciationrate(PropertyAge,Y):- PropertyAge=<10, PropertyAge>5, Y=3.
depreciationrate(PropertyAge,Y):- PropertyAge=<15, PropertyAge>10, Y=7.
depreciationrate(PropertyAge,Y):- PropertyAge=<20, PropertyAge>15, Y=11.
depreciationrate(PropertyAge,Y):- PropertyAge=<25, PropertyAge>20, Y=16.
depreciationrate(PropertyAge,Y):- PropertyAge=<30, PropertyAge>25, Y=21.
depreciationrate(PropertyAge,Y):- PropertyAge=<35, PropertyAge>30, Y=26.
depreciationrate(PropertyAge,Y):- PropertyAge=<40, PropertyAge>35, Y=31.
depreciationrate(PropertyAge,Y):- PropertyAge=<45, PropertyAge>40, Y=36.
depreciationrate(PropertyAge,Y):- PropertyAge=<50, PropertyAge>45, Y=41.
depreciationrate(PropertyAge,Y):- PropertyAge=<55, PropertyAge>50, Y=46.
depreciationrate(PropertyAge,Y):- PropertyAge=<60, PropertyAge>55, Y=52.
depreciationrate(PropertyAge,Y):- PropertyAge=<65, PropertyAge>60, Y=57.
depreciationrate(PropertyAge,Y):- PropertyAge=<75, PropertyAge>65, Y=63.
depreciationrate(PropertyAge,Y):- PropertyAge=<80, PropertyAge>75, Y=68.
depreciationrate(PropertyAge,Y):- PropertyAge=<85, PropertyAge>80, Y=74.
depreciationrate(PropertyAge,Y):- PropertyAge=<90, PropertyAge>85, Y=80.
depreciationrate(PropertyAge,Y):- PropertyAge=<95, PropertyAge>90, Y=86.
depreciationrate(PropertyAge,Y):- PropertyAge>95, Y=92.

depreciation(PropertyPrice,PropertyAge,Z):- depreciationrate(PropertyAge, X), Z is PropertyPrice * (X/100).

% Loan = Estate Price + Property Price  – Depreciation
loan(EstateSqm, 
     EstatePriceSqm, 
     Distance,
     PropertyM3,
     Rooms, 
     RoomPriceSqm, 
     KitchenSqm, 
     KitchenPriceSqm, 
     Floors, 
     Roof, 
     BasementSqm, 
     Garage, 
     PropertyAge, X):- 
        estateprice(EstatePriceSqm, EstateSqm, U), 
        propertyprice(
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
        depreciation(V, PropertyAge,W), 
        X is U+V-W.

% First Mortgage = (66% of loan) - [Security]
firstMortgage(Loan,Security,X):- X is (Loan * 0.66) - Security.

% Second Mortgage = 14% of [loan]
secondMortgage(Loan,X):- X is (Loan * 0.14).

% Mortgage Interest = 5% (First Mortgage + Second Mortgage)
mortageInterest(Loan, Security, Z):- firstMortgage(Loan, Security, X), secondMortgage(Loan, Y), Z is (X+Y) * 0.05.

% Additional Costs p.a. = 1% of Loan p.a.
additionalCost(Loan,X):- X is (Loan * 0.01).

% Total Liabilities p.a. = Additional Costs p.a. + Mortgage Interest p.a.
totalLiabilites(Loan, Security, Z):-  additionalCost(Loan, X), mortageInterest(Loan, Security, Y), Z is X+Y.

% Calculatory Affordability = Total Liabilities / [Income]
calculatoryAfforadbility(Loan, Income, Security, Z):- totalLiabilites(Loan, Security, X), Z is X/Income.

% Provided Cash Ratio = Capital/Loan
providedCashRatio(Capital, Loan, X):- X is (Capital/Loan). 

% Virtual API for ZEK Entries
% Checks if a Person has a ZEK Entry (which is not good)
zekEntry("Beatrice", "Sutter").
zekEntry("Karin", "Keller").
zekEntry("Peter", "Meier").
zekEntry("Melanie", "Graber").
zekEntry("Stephan", "Ospel").
zekEntry("Holger", "Wache").

% Virtual API for Pythagoras Entry
% Checks if a Person is in the Pythagoras list (which is not good)
pythagorasEntry("Max", "Muster").
pythagorasEntry("Hans", "Glauser").
pythagorasEntry("Hans", "Tester").
pythagorasEntry("Hans", "Müller").
pythagorasEntry("Hans", "Holzer").
pythagorasEntry("Rolf", "Mustermann").

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
            X),
        
    propertysqmprice(X,Y).

pointscalculation(Distance, Rooms, RoomPriceSqm, KitchenSqm, 
KitchenPriceSqm, Floors, Roof, BasementSqm, Garage, Z):- 
    distance(Distance, N), 
    rooms(Rooms, O),  
    roompricesqm(RoomPriceSqm, P), 
    kitchensqm(KitchenSqm,Q), 
    kitchenpricesqm(KitchenPriceSqm,R), 
    floors(Floors,S), 
    roof(Roof,T), 
    basementsqm(BasementSqm,U), 
    garage(Garage,V), 
    Z is (N+O+P+Q+R+S+T+U+V) / 9.

propertysqmprice(X,Y):- X>=1, X<2, Y is 300.
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
kitchensqm(X,Y):- X>=20, X<30, Y=5.
kitchensqm(X,Y):- X>=15, X<20, Y=4.
kitchensqm(X,Y):- X>=10, X<15, Y=3.
kitchensqm(X,Y):- X>=5, X<10, Y=2.
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
basementsqm(X,Y):- X>=120, X<150, Y=5.
basementsqm(X,Y):- X>=100, X<120, Y=4.
basementsqm(X,Y):- X>=60, X<100, Y=3.
basementsqm(X,Y):- X>20, X<60, Y=2.
basementsqm(X,Y):- X=<20,Y=1.

garage(X,Y):- X="Tiefgarage", Y=6.
garage(X,Y):- X="Doppel", Y=5.
garage(X,Y):- X="Einzel", Y=4.
garage(X,Y):- X="Gemeinschaft", Y=4.
garage(X,Y):- X="Carport", Y=2.
garage(X,Y):- X="Nein", Y=1.
