SELECT rd.Season, rd.Wscore, rd.Season, rd.Daynum, rd.Wteam FROM RegularSeasonDetailedResults rd
INNER JOIN Teams t
ON t.Team_Id = rd.Wteam
ORDER BY rd.Season

-- wins by team and season
SELECT  rd.Wteam, rd.Season, t.Team_Name,
COUNT(*) as Wins FROM RegularSeasonDetailedResults rd
INNER JOIN Teams t
on t.Team_Id = rd.Wteam
GROUP BY rd.Wteam, rd.Season, t.Team_Name
order BY rd.Wteam, rd.Season ASC


SELECT  rd.Lteam , rd.Season, t.Team_Name,
COUNT(*) as Losses FROM RegularSeasonDetailedResults rd
INNER JOIN Teams t
on t.Team_Id = rd.Lteam
GROUP BY rd.Lteam, rd.Season, t.Team_Name
order BY rd.Lteam, rd.Season ASC


-- semifinals, winning teams 
-- Connecticut has won the most number of Semifinals
SELECT rd.Wteam, t.Team_Name, COUNT(*) as SemiFWins FROM TourneyDetailedResults rd
INNER JOIN Teams t
ON t.Team_Id = rd.Wteam
WHERE rd.Daynum = 152
group BY t.Team_Name, rd.Wteam
ORDER BY SemiFWins DESC

-- Michigan St has the most number of SemiFinal losses
SELECT rd.Lteam, t.Team_Name, COUNT(*) as SemiFLosses FROM TourneyDetailedResults rd
INNER JOIN Teams t
ON t.Team_Id = rd.Lteam
WHERE rd.Daynum = 152
group BY t.Team_Name, rd.Lteam
ORDER BY SemiFLosses DESC



-- largest loss margin was Connecticut-Chattanooga in 2009
SELECT CONVERT(int, td.Wscore) - CONVERT(int, td.Lscore) as 'Margin', td.Wteam, tw.Team_Name as Won, td.Lteam,
tl.Team_Name as Lost,
 td.Season
FROM TourneyDetailedResults td
INNER JOIN Teams tw
ON tw.Team_Id = td.Wteam
INNER JOIN Teams tl
on tl.Team_Id = td.Lteam
ORDER BY Margin, td.Season



-- largest loss margin in semifinals Kansas - Marquette in 2003
SELECT CONVERT(int, td.Wscore) - CONVERT(int, td.Lscore) as 'Margin', td.Wteam, tw.Team_Name as Won, td.Lteam,
tl.Team_Name as Lost,
 td.Season
FROM TourneyDetailedResults td
INNER JOIN Teams tw
ON tw.Team_Id = td.Wteam
INNER JOIN Teams tl
on tl.Team_Id = td.Lteam
WHERE td.Daynum = 152
ORDER BY Margin, td.Season



-- final wins, woah Connecticut!
SELECT rd.Wteam, t.Team_Name, COUNT(*) as FinalWins FROM TourneyDetailedResults rd
INNER JOIN Teams t
ON t.Team_Id = rd.Wteam
WHERE rd.Daynum = 154
group BY t.Team_Name, rd.Wteam
ORDER BY FinalWins DESC

-- final losses
SELECT rd.Lteam, t.Team_Name, COUNT(*) as FinalLosses FROM TourneyDetailedResults rd
INNER JOIN Teams t
ON t.Team_Id = rd.Lteam
WHERE rd.Daynum = 154
group BY t.Team_Name, rd.Lteam
ORDER BY FinalLosses DESC


