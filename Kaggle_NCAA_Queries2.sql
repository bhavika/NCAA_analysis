
-- finals by Season
SELECT Wteam as Won,  tw.Team_Name as WinTeam,  Lteam as Lost, tl.Team_Name as LosTeam, Season from TourneyDetailedResults td
INNER JOIN Teams tw
ON td.Wteam = tw.Team_Id
INNER JOIN Teams tl
ON tl.Team_Id = td.Lteam
where Daynum = 154



SELECT * FROM TourneyDetailedResults td, TourneyDetailedResults td2
where td.Wteam = td2.Lteam
and td.Daynum = 154
and td.Season = 2003


