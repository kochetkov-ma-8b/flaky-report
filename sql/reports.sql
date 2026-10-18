.mode column
.headers on

-- 1. Flaky: tests that both passed and failed over the stored runs, worst ratio first.
SELECT suite,
       test_name,
       COUNT(*)                                          AS runs,
       SUM(status = 'failed')                            AS failed,
       ROUND(100.0 * SUM(status = 'failed') / COUNT(*), 1) AS fail_pct
FROM test_result
GROUP BY suite, test_name
HAVING SUM(status = 'passed') > 0 AND SUM(status = 'failed') > 0
ORDER BY fail_pct DESC, test_name;

-- 2. Always red: never passed, so a real defect rather than flakiness.
SELECT suite, test_name, COUNT(*) AS runs
FROM test_result
GROUP BY suite, test_name
HAVING SUM(status = 'passed') = 0 AND SUM(status = 'failed') > 0
ORDER BY suite, test_name;

-- 3. Pass rate per suite, skipped excluded from the denominator.
SELECT suite,
       COUNT(*)                                                                AS results,
       SUM(status = 'skipped')                                                 AS skipped,
       ROUND(100.0 * SUM(status = 'passed') / NULLIF(SUM(status <> 'skipped'), 0), 1) AS pass_pct
FROM test_result
GROUP BY suite
ORDER BY pass_pct, suite;

-- 4. Slowest tests by average duration.
SELECT suite,
       test_name,
       ROUND(AVG(duration_ms)) AS avg_ms,
       MAX(duration_ms)        AS max_ms
FROM test_result
WHERE status <> 'skipped'
GROUP BY suite, test_name
ORDER BY avg_ms DESC
LIMIT 5;

-- 5. Per-run health, newest first.
SELECT r.id,
       r.started_at,
       r.commit_sha,
       SUM(t.status = 'failed') AS failed,
       COUNT(*)                 AS total
FROM test_run r
         JOIN test_result t ON t.run_id = r.id
GROUP BY r.id, r.started_at, r.commit_sha
ORDER BY r.started_at DESC;
