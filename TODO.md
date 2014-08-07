#Twitter Raffle - TODO#
Campaign over boolean
-Can pick winners
-Can no longer change end time
-Can no longer pull in more tweets (hide link)
-Set automatically when time expires (scheduled job)
-Option to require minimum number of entries (auto extend?)

User must be logged in to see campaigns
-Controll access on all controller actions
-User can only access own campaign

Winner selection
-Max number of entries (campaign attribute)
  -Mark tweets as "invalid" if they have reached limit
-Cannot win multiple prizes in same campaign

Announcement Model
-Send tweet when campaign starts
-Tweet reminders (e.g. 1 hour left)

User message model
-Your stats are ready
-Email when campaign ends

Ajax/JS improvements
-Add/Edit/Delete multiple prizes

Data control
-Delete tweets when campaign is deleted
-Should users even delete campaigns?

Better default view
-Tabs for ongoing/completed/all campaigns

Analytics
-Basic bar graph: number of tweets per campaign
-Bar/line/pie graphs
-Reach
-Anything cool we can do with D3
-Install gon gem?
-Add link to navbar

Stream tweets
-Node.js?

Hashtag generator
-Ensure hashtag is not already being heavily used

Bootstrap/Styling