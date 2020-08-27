--------------------------------------------------------------------------------

-- 사원수가 가장 많은 부서의 사원중 부서평균급여보다 많이 받는 사원들의
-- 사원이름, 직급, 급여, 부서번호, 부서평균급여, 부서원수 를 조회하세요.

--------------------------------------------------------------------------------

SELECT
    ename 사원이름, job 직급, sal 급여, deptno 부서번호, ROUND(avg, 2) 부서평균급여, cnt 부서원수
FROM
    emp,
    (
        SELECT
            deptno dno, AVG(sal) avg, COUNT(*) cnt
        FROM
            emp
        GROUP BY
            deptno
    ) 
WHERE
    deptno = dno
    AND cnt =   (
                    SELECT
                        MAX(COUNT(*))
                    FROM
                        emp
                    GROUP BY
                        deptno
                )
    AND sal > avg
;