###Umpire Auditor has been heavily refactored and is now maintained at https://github.com/dyep49/Angular-Umpire-Auditor

#Umpire Auditor


After every game, the MLB releases an incredible amount of data. In fact, every single pitch brings back nearly 30 different characteristics. [Umpire Auditor](http://umpireauditor.herokuapp.com) uses this data to track (or audit) the performance of MLB umpires, primarily by calculating the rate at which these umpires correctly calculate balls and strikes.

At it's most basic, the application returns the worst call of the night, every night, chosen as such for being the ball, called strike, furthest from the strike zone. In addition, umpire performance statistics exist in the application for every game and cumulatively over the entire season.

This application made extensive use of the 'gameday_api' gem and 'nokogiri' to download (gameday_api gem) and parse ('nokogiri') the xml provided by the MLB's API. 

Becuase the data released is so extensive, it was not practical to hit the MLB API everytime information was needed. As a result, the necessary files were downloaded by the game_day_api gem, parsed, and added to a Postgres database. Because there were so many files (500,000+ per season), it was necessary to parse the xml into a Ruby hash and convert that to csv. From there, the data was inserted into the database using Postgres. There were about one million rows inserted per season. 

To ensure faster response time, some resource intensive calls were generated in a seed task, run daily, and stored in a csv file.


```
def strike?
    if self.width_strike? && self.height_strike?
        "Called Strike"
    else
        "Ball"
    end
end

def correct_call?
    self.strike? == self.description
end

def width_strike?
    half_plate_width = (17.5/12)/2
    self.x_location.abs < half_plate_width 
end

def height_strike?
    (self.y_location < self.sz_top) && (self.y_location > self.sz_bottom)
end

def distance_miss
    half_plate_width = (17.5/12)/2
    if self.y_location > self.sz_top
        self.distance_missed_y = (self.y_location - self.sz_top).round(2)
    elsif self.y_location < self.sz_bottom 
        self.distance_missed_y = (self.sz_bottom - self.y_location).round(2)
        else
        self.distance_missed_y = 0
    end

    if self.x_location.abs > half_plate_width
        self.distance_missed_x = (self.x_location.abs - half_plate_width).round(2)
    else
        self.distance_missed_x = 0
    end
    self.total_distance_missed = self.distance_missed_y + self.distance_missed_x
 end
 ```
