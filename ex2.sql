SELECT  JOB, ROUND(AVG(SAL), 2) AS MEDIA_SALARIAL
FROM    EMP 
GROUP BY JOB