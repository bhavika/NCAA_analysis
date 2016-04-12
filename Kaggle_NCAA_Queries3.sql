-- max overtime periods in a single game - 2009 
SELECT ROW_NUMBER() OVER (PARTITION BY Numot ORDER by Numot) as 'row num',
MAX(Numot) as 'Overtime', t.Team_Name as Won, l.Team_Name as Lost,  rd.Season FROM 
RegularSeasonDetailedResults rd
INNER JOIN Teams t
ON rd.Wteam = t.Team_Id
INNER JOIN Teams l
ON rd.Lteam = l.Team_Id
GROUP BY Numot, t.Team_Name, l.Team_Name, Season
ORDER BY Numot desc


SELECT ROW_NUMBER() OVER (PARTITION BY Numot ORDER by Numot) as 'row num',
MAX(Numot) as 'Overtime', t.Team_Name as Won, l.Team_Name as Lost,  rd.Season FROM 
TourneyDetailedResults rd
INNER JOIN Teams t
ON rd.Wteam = t.Team_Id
INNER JOIN Teams l
ON rd.Lteam = l.Team_Id
GROUP BY rd.Season, rd.Wteam, rd.Lteam, rd.Numot,  t.Team_Name, l.Team_Name
ORDER BY Numot desc


-- home vs away matches
-- Ohio state has had the most home wins since 2010
SELECT t.Team_Name, Wteam ,COUNT(Wloc) as HomeWins FROM RegularSeasonDetailedResults
INNER JOIN Teams t
ON t.Team_Id = Wteam
 where Wloc = 'H'
and Season > 2010
GROUP BY t.Team_Name, Wteam
ORDER BY HomeWins desc


-- Memphis has had the most Home wins of all time
SELECT t.Team_Name, Wteam ,COUNT(Wloc) as HomeWins FROM RegularSeasonDetailedResults
INNER JOIN Teams t
ON t.Team_Id = Wteam
 where Wloc = 'H'
GROUP BY t.Team_Name, Wteam
ORDER BY HomeWins desc


-- total matches played by Morris Brown
SELECT * FROM RegularSeasonDetailedResults 
where Wteam = 1289 
and Season = 2003
UNION 
SELECT * FROM RegularSeasonDetailedResults 
where Lteam = 1289 
and Season = 2003



-- Vermont had the most number of away wins
SELECT t.Team_Name, Wteam ,COUNT(Wloc) as AwayWins FROM RegularSeasonDetailedResults
INNER JOIN Teams t
ON t.Team_Id = Wteam
 where Wloc = 'A'
GROUP BY t.Team_Name, Wteam
ORDER BY AwayWins desc


-- San Jose State lost the most number of away matches
SELECT t.Team_Name, Lteam ,COUNT(Wloc) as AwayLosses FROM RegularSeasonDetailedResults
INNER JOIN Teams t
ON t.Team_Id = Lteam
 where Wloc = 'A'
GROUP BY t.Team_Name, Lteam
ORDER BY AwayLosses desc


--win loss percentage for each team
SELECT x1.Team_Name, x1.Wins, x2.Losses, x1.Wins + x2.Losses as Total, 
 (convert(decimal(5,2),
 CONVERT(float,x1.Wins)/ CONVERT(float,(x1.Wins + x2.Losses))*100)) 
   as WinPercentage ,
    (convert(decimal(5,2),
 CONVERT(float,x2.Losses)/ CONVERT(float,(x1.Wins + x2.Losses))*100)) 
   as LossPercennage 
   from
(SELECT COUNT(rd.Wteam) as Wins, t.Team_Name FROM RegularSeasonDetailedResults rd
INNER JOIN Teams t
ON rd.Wteam = t.Team_Id
GROUP BY rd.Wteam, t.Team_Name) x1
LEFT JOIN
(SELECT COUNT(rd.Lteam) as Losses, t.Team_Name from RegularSeasonDetailedResults rd
INNER JOIN Teams t
ON rd.Lteam = t.Team_Id
GROUP BY rd.Lteam, t.Team_Name) x2
ON x1.Team_Name = x2.Team_Name


