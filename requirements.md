# Clean Code
- refactor for naming of things
- make methods concise and readable
- write tests
- do data validation at every step
- banners for successful or unsuccessful operations

# Pages
## Dashboard (Launchpad home)
## Log
Add entry: Date, course, lesson, hours, minutes, notes
- sort each column ascending or descending
- search a string and pull up every record (row) that contains that string

## Progress
- display hours of study for each course and an estimated % complete
- each course is either Not started, In progress, or Completed
-   Not started is if you don't have any logged hours
-   In progress is if you have any logged hours
-   Completed is manually marked
- In progress % complete estimate is based on three speeds: slow, moderate, fast for each course
-   calculated by: number of study hours so far / average total time for course at a certain speed

## Calendar
- projected date to complete the course and assessment
-   calculated by: current date + (average time for course - study hours so far) / average study hours per day over last 28 days
-   projection calculation based on slow, moderate, fast and rolling average or custom input
- scheduled date to actually take the assessment
- past dates for when the assessment was taken and your result


## Reports
- Study streak
-   XX days in a row!
- Column graph - study hours per time period
-   Calendar Week (Sunday to Saturday)
-   Calendar Month
-   Rolling Week (last 7 days)
-   Rolling Month (last 28 days by week buckets)
-   Custom (when greater than or equal to 28 days, organize into week buckets)
- Banded bar chart
-   Study hours per course with lesson bands
-   Study hours per course with course/assessment bands
- Pie chart
-   % of study hours per course (assessment separate)
-   % of study hours per course (assessment combined)
- Statistics
-   Total study hours
-   Total study hours per week
-   Total study hours per course
-   Average study hours per day
-   Average study hours per active day
-   Average study hours per week
-   Average study hours per active week (a week in which you study at least one day)

## About

## Account

# Style
Start with semantic HTML
- know the stucture and all the needed containers
- use header, footer, section, nav, main, article, etc. as needed
CSS that is reusable and clearly named
Modeled after Launch School's website