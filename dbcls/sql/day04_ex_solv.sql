/*
    5. 각 사원의 급여와 평균급여의 차이를 조회하세요.
*/

-- 평균급여 조회
SELECT
    empno, ename,
    sal -
        (SELECT
            AVG(sal)
        FROM
            emp)
FROM
    emp
;

select
    (10 - (select 9/3 from dual)) 계산결과
from
    dual
;

/*
    6. 부서의 급여합계가 가장 높은 부서의 사원들의 정보를 조회하세요.
*/

SELECT
    *
FROM
    emp
WHERE
    deptno =(SELECT
                deptno
            FROM
                emp
            GROUP BY
                deptno
            HAVING
                SUM(sal) = (
                                SELECT
                                    MAX(sum)
                                FROM
                                    (
                                        SELECT
                                            SUM(sal) sum
                                        FROM
                                            emp
                                        GROUP BY
                                            deptno
                                    )
                            )
            ) 
;

SELECT
    *
FROM
    emp
WHERE
    deptno =(SELECT
                deptno
            FROM
                emp
            GROUP BY
                deptno
            HAVING
                SUM(sal) = (
                                SELECT
                                    MAX(SUM(sal))
                                FROM
                                    emp
                                GROUP BY
                                    deptno
                            )
            ) 
;

/*
    8. 평균급여보다 급여가 높고 이름이 4글자 또는 5글자인 사원의 정보를 조회하세요.
*/
SELECT
    e.*, 
    (SELECT
                AVG(sal)
            FROM
                emp) 평균급여
FROM
    emp e
WHERE
    sal >   (SELECT
                AVG(sal)
            FROM
                emp)
    AND LENGTH(ename) IN (4, 5);

/*
    13. 최고 급여자의 이름길이와 같은 이름길이를 갖는 사원이 존재하면
        모든 사원의 정보를 조회하고
        아니면 조회하지마세요.    ---- EXISTS
*/

-- 최고급여자의 이름길이

SELECT
    *
FROM
    emp
WHERE
     EXISTS    (SELECT
                    *
                FROM
                    emp
                WHERE
                    LENGTH(ename) = (SELECT
                                        LENGTH(ename)
                                    FROM
                                        emp
                                    WHERE
                                        sal =   (
                                                    SELECT
                                                        MAX(sal)
                                                    FROM
                                                        emp
                                                )
                                    )
                        AND ename <> 'KING'
                )
;