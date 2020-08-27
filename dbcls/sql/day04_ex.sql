-- day04 과제

/*
    1. SMITH 사원과 동일한 직급을 가진 사원의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    job = (
                SELECT
                    job
                FROM
                    emp
                WHERE
                    ename = 'SMITH'
            )
;
/*
    2. 사원들의 평균급여보다 적게 받는 사원의 정보를 조회하세요.  
*/
SELECT
    *
FROM
    emp
WHERE
    sal <   (
                SELECT
                    AVG(sal)
                FROM
                    emp
            )
;
/*
    3. 최고급여자의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    sal =   (
                SELECT
                    MAX(sal)
                FROM
                    emp
            )
;
/*
    4. KING 사원보다 늦게 입사한 사원의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    hiredate > (
                    SELECT
                        hiredate
                    FROM
                        emp
                    WHERE
                        ename = 'KING'
                )
;
/*
    5. 각 사원의 급여와 평균급여의 차이를 조회하세요.
*/

/*
    6. 부서의 급여합계가 가장 높은 부서의 사원들의 정보를 조회하세요.
*/
SELECT
    empno, ename, sal, deptno
FROM
    emp
WHERE
    deptno = (
                SELECT
                    deptno
                FROM
                    emp
                GROUP BY
                    deptno
                HAVING
                    sum(sal) = (
                                    SELECT
                                        max(sum(sal))
                                    FROM
                                        emp
                                    GROUP BY
                                        deptno
                                )
            )
;

SELECT
    empno, ename, sal, deptno
FROM
    emp
WHERE
    deptno = (
                SELECT
                    deptno
                FROM
                    emp
                GROUP BY
                    deptno
                HAVING
                    sum(sal) = (
                                    SELECT
                                        max(sum)
                                    FROM
                                        (
                                            SELECT
                                                deptno dno, sum(sal) sum
                                            FROM
                                                emp
                                            GROUP BY
                                                deptno
                                        )
                                )
            )
;
/*
    7. 커미션을 받는 직원이 한사람이라도 있는 부서의 소속 사원들의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    deptno IN (
                    SELECT
                        DISTINCT deptno
                    FROM
                        emp
                    WHERE
                        comm IS NOT NULL
                )
;
/*
    8. 평균급여보다 급여가 높고 이름이 4글자 또는 5글자인 사원의 정보를 조회하세요.
*/

/*
    9. 사원의 이름이 4글자로된 사원과 같은 직급의 사원들의 정보를 조회하세요.
*/

/*
    10. 입사년도가 81년이 아닌 사원과 같은 부서에 있는 사원의 정보를 조회하세요.
*/


SELECT
    *
FROM
    emp
WHERE
    deptno IN (
                SELECT
                    DISTINCT deptno
                FROM
                    emp
                WHERE
                --    hiredate NOT BETWEEN '1981/01/01' AND '1982/01/01'
                    NOT TO_CHAR(hiredate, 'yy') = '81'
                    /*
                        부정연산자
                            <>
                            !=
                            ^=
                            NOT
                    */
                )
;


/*
    11. 하나라도 직급별 평균급여보다 조금이라도 많이 받는 사원의 정보를 조회하세요. -- ANY
*/

/*
    12. 모든 입사년도 평균급여보다 많이 받는 사원의 정보를 조회하세요.
*/

/*
    13. 최고 급여자의 이름길이와 같은 이름길이를 갖는 사원이 존재하면
        모든 사원의 정보를 조회하고
        아니면 조회하지마세요.
*/