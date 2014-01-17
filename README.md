#Umpire Auditor


After every game, the MLB releases an incredible amount of data. In fact, every single pitch brings back nearly 30 different characteristics. Umpire Auditor uses this data to track (or audit) the performance of MLB umpires, primarily by calculating the rate at which these umpires correctly calculate balls and strikes.

At it's most basic, the application returns the worst call of the night, every night, chosen as such for being the ball, called strike, furtherst from the strike zone. In addition, umpire performance statistics exist for every game and cumulatively over the entire season.

This application made extensive use of the 'gameday_api' gem and 'nokogiri' to download (gameday_api gem) and parse ('nokogiri') the xml provided by the MLB's API. 

Becuase the data released is so extensive, it was not practical to hit the MLB API everytime information was needed. As a result, the necessary files were downloaded by the game_day_api gem, parsed, and added to a Postgres database. Because there were so many files (500,000+ per season), it was necessary to parse the xml into a Ruby hash and convert that to csv. From there, the data was inserted into the database using Postgres. There were about one million rows inserted per season. 

