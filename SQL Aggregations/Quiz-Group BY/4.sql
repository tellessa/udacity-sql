-- Find the total number of times
-- each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.
-- total means you have to use SUM() function
-- Wrong, you need the count() function
-- Each type probably means need to group by.
-- Select 2 columns: the channel, number of times it was used
SELECT channel,
    COUNT(channel)
FROM web_events
GROUP BY channel;
-- Their answer
SELECT w.channel,
    COUNT(*)
FROM web_events w
GROUP BY w.channel;