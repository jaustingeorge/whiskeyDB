DROP TABLE Distiller;
DROP TABLE Bottler;
DROP TABLE Bottle;
DROP TABLE Purchase;
-- a tuple in the distiller table represents a distiller of whiskey
CREATE TABLE Distiller (
    distillerID TEXT PRIMARY KEY, -- unique distiller id
    name TEXT NOT NULL,           -- name of distiller
    city TEXT,                    -- city where distiller is located
    state TEXT,                   -- state where distiller is located
    country TEXT                  -- country where distillery is located
);

-- a tuple in the bottler table represents a bottler or blender of whiskey
CREATE TABLE Bottler (
    bottlerID TEXT PRIMARY KEY,  -- unique bottler id
    name TEXT NOT NULL,          -- name of bottler
    city TEXT,                   -- city where bottler is located
    state TEXT,                  -- state where bottler is located
    country TEXT                 -- country where bottler is located
);

-- a tuple in the bottle table represents a bottle of whiskey.
-- if bottlerID is NULL, then the distiller is also the bottler.
CREATE TABLE Bottle (
    bottleID TEXT PRIMARY KEY,              -- unique bottle id
    name TEXT NOT NULL,                     -- product name
    style TEXT,                             -- style of whiskey
    distillerID TEXT REFERENCES Distiller,  -- distiller of the product
    bottlerID TEXT REFERENCES Bottler       -- bottler of the product
);

CREATE TABLE Purchase (
    purchaseID TEXT PRIMARY KEY,     -- unique purchase id
    bottleID TEXT REFERENCES Bottle, -- bottle that was purchased
    price REAL,                      -- cost of the bottle
    onShelf INTEGER                  -- 1 available, 0 not on shelf
);
-- distillerID, name, city, state, country
INSERT INTO Distiller VALUES ('1','Maker’s Mark Distillery',
    'Loretto','KY','USA');
INSERT INTO Distiller VALUES ('2','Irish Distillers',
    'Midleton',NULL,'Ireland');
INSERT INTO Distiller VALUES ('3','High West Distillery',
    'Park City','UT','USA');
INSERT INTO Distiller VALUES ('4','Hamilton Distillers',
    'Tucson','AZ','USA');
INSERT INTO Distiller VALUES ('5','William Maxwell & Co.',
    NULL,NULL,'Scotland');
INSERT INTO Distiller VALUES ('6','Witherspoon Distillery',
    'Lewisville','TX','USA');
INSERT INTO Distiller VALUES ('7','William Grant & Sons',
    'Dufftown',NULL,'Scotland');
INSERT INTO Distiller VALUES ('8','Glenmorangie Distillery Co.',
    'Tain',NULL,'Scotland');
INSERT INTO Distiller VALUES ('9','TerrePURE Spirits',
    'North Charleston','SC','USA');
INSERT INTO Distiller VALUES ('10','D. Johnston & Co.',
    'Isle of Islay',NULL,'Scotland');
INSERT INTO Distiller VALUES ('11','Midwest Grain Products',
    'Lawrenceburg','IN','USA');
INSERT INTO Distiller VALUES ('12','Wyoming Whiskey Inc.',
    'Kirby','WY','USA');
INSERT INTO Distiller VALUES ('13','Four Roses Distillery',
    'Lawrenceburg','KY','USA');
INSERT INTO Distiller VALUES ('14','Tullamore Dew Company',
    'Bury Quay',NULL,'Ireland');
INSERT INTO Distiller VALUES ('15','Oban Distillery',
    'Oban','Argyll','Scotland');
INSERT INTO Bottler VALUES ('1','George Dickel & Co.','Norwalk','CT','USA');
INSERT INTO Bottler VALUES ('2','High West Distillery','Park City','UT','USA');
INSERT INTO Bottler VALUES ('3','William Maxwell & Co.',NULL,NULL,'Scotland');
INSERT INTO Bottler VALUES ('4','Spencerfield Spirit Co.','Inverkeithing','Fife','Scotland');
-- bottleID, name, style, distillerID, bottlerID
INSERT INTO Bottle VALUES ('1', 'Maker''s Mark Bourbon', 'Straight Bourbon','1',NULL);
INSERT INTO Bottle VALUES ('2', 'Redbreast 12', 'Single Pot Still','2',NULL);
INSERT INTO Bottle VALUES ('3', 'Silver Whiskey Western Oat','Light Whiskey','3',NULL);
INSERT INTO Bottle VALUES ('4', 'Whiskey Del Bac Classic','Single Malt','4',NULL);
INSERT INTO Bottle VALUES ('5', 'Whiskey Del Bac Dorado','Single Malt','4',NULL);
INSERT INTO Bottle VALUES ('6', 'Double Rye!','Blended Straight Rye','11','2');
INSERT INTO Bottle VALUES ('7', 'Shieldaig 12','Speyside',NULL,'3');
INSERT INTO Bottle VALUES ('8', 'Witherspoon''s Straight Bourbon','Straight Bourbon','6',NULL);
INSERT INTO Bottle VALUES ('9', 'Glenfiddich 12','Speyside','7',NULL);
INSERT INTO Bottle VALUES ('10', 'Glenmorangie Original','Highland','8',NULL);
INSERT INTO Bottle VALUES ('11', 'Copper Pony Rye','Rye','9',NULL);
INSERT INTO Bottle VALUES ('12', 'Laphroaig 10','Islay','10',NULL);
INSERT INTO Bottle VALUES ('13', 'George Dickel Rye Whisky','Rye','11','1');
INSERT INTO Bottle VALUES ('14', 'Winchester Straight Bourbon','Straight Bourbon','9',NULL);
INSERT INTO Bottle VALUES ('15', 'Rendezvous Rye','Blended Straight Rye','11','2');
INSERT INTO Bottle VALUES ('16', 'Wyoming Whiskey','Small Batch Bourbon','12',NULL);
INSERT INTO Bottle VALUES ('17', 'Four Roses Single Barrel','Straight Bourbon','13',NULL);
INSERT INTO Bottle VALUES ('18', 'Tullamore D.E.W.','Blended Irish','14',NULL);
INSERT INTO Bottle VALUES ('19', 'Oban 14','Highland','15',NULL);
INSERT INTO Bottle VALUES ('20', 'Pig''s Nose','Blended Scotch',NULL,'4');
-- purchaseID, bottleID, price, onShelf
INSERT INTO Purchase VALUES ('1','1',20,0);  -- Maker's Mark
INSERT INTO Purchase VALUES ('2','1',20,0);  -- Maker's Mark
INSERT INTO Purchase VALUES ('3','2',58,0);  -- Redbreast 12
INSERT INTO Purchase VALUES ('4','3',39,1);  -- Western Oat
INSERT INTO Purchase VALUES ('5','4',40,0);  -- Whiskey Del Bac Classic
INSERT INTO Purchase VALUES ('6','4',40,0);
INSERT INTO Purchase VALUES ('7','4',40,0);
INSERT INTO Purchase VALUES ('8','4',32,1);
INSERT INTO Purchase VALUES ('9','5',50,1);    -- Del Bac Dorado
INSERT INTO Purchase VALUES ('10','6',39,0);   -- Double Rye
INSERT INTO Purchase VALUES ('11','7',27,0);   -- Shieldaig 12
INSERT INTO Purchase VALUES ('12','8',40,0);   -- Witherspoon
INSERT INTO Purchase VALUES ('13','9',30,0);   -- Glenfiddich 12
INSERT INTO Purchase VALUES ('14','10',33,0);  -- Glenmorangie Original
INSERT INTO Purchase VALUES ('15','11',20,0);  -- Copper Pony
INSERT INTO Purchase VALUES ('16','12',30,1);  -- Laphroaig 10
INSERT INTO Purchase VALUES ('17','13',28,1);  -- Dickel Rye
INSERT INTO Purchase VALUES ('18','14',19,1);  -- Winchester
INSERT INTO Purchase VALUES ('19','15',52,1);  -- Rendezvous Rye
INSERT INTO Purchase VALUES ('20','16',40,1);  -- Wyoming Whiskey
INSERT INTO Purchase VALUES ('21','17',40,1);  -- Four Roses Single Barrel
INSERT INTO Purchase VALUES ('22','18',15,1);  -- Tullamore D.E.W.
INSERT INTO Purchase VALUES ('23','19',59,1);  -- Oban 14
INSERT INTO Purchase VALUES ('24','20',29,0);  -- Pig's Nose
