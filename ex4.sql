SELECT  JOB, ROUND(AVG(SAL), 2) AS MEDIA_SALARIAL, DECODE(
            SAL, 
            1500, SAL + (SAL * 0.2), 
            3000, SAL + (SAL * 0.15), 
            SAL + (SAL * 0.1)
        ) AS MEDIA_REMUNERACAO
FROM    EMP
GROUP BY JOB