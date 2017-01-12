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
