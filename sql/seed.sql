-- Five CI runs of the same 6 tests; some stable, some flaky, one permanently red.

INSERT INTO test_run (id, branch, commit_sha, started_at) VALUES
    (1, 'main', 'a1c0f31', '2025-09-29T07:40:11Z'),
    (2, 'main', 'b7e2d09', '2025-09-30T07:41:02Z'),
    (3, 'main', 'c3419af', '2025-10-01T07:39:55Z'),
    (4, 'main', 'd0b8e74', '2025-10-02T07:40:48Z'),
    (5, 'main', 'e55a1c2', '2025-10-03T07:42:17Z');

INSERT INTO test_result (run_id, suite, test_name, status, duration_ms) VALUES
    (1, 'api', 'test_login',         'passed',   412),
    (1, 'api', 'test_logout',        'passed',   180),
    (1, 'api', 'test_refresh_token', 'failed',  3015),
    (1, 'ui',  'test_checkout',      'passed',  8140),
    (1, 'ui',  'test_search',        'failed',  1220),
    (1, 'ui',  'test_profile',       'passed',  2310),

    (2, 'api', 'test_login',         'passed',   398),
    (2, 'api', 'test_logout',        'passed',   175),
    (2, 'api', 'test_refresh_token', 'passed',  1180),
    (2, 'ui',  'test_checkout',      'failed',  9025),
    (2, 'ui',  'test_search',        'failed',  1198),
    (2, 'ui',  'test_profile',       'skipped',    0),

    (3, 'api', 'test_login',         'passed',   455),
    (3, 'api', 'test_logout',        'passed',   168),
    (3, 'api', 'test_refresh_token', 'failed',  3102),
    (3, 'ui',  'test_checkout',      'passed',  8630),
    (3, 'ui',  'test_search',        'failed',  1241),
    (3, 'ui',  'test_profile',       'passed',  2290),

    (4, 'api', 'test_login',         'passed',   402),
    (4, 'api', 'test_logout',        'passed',   171),
    (4, 'api', 'test_refresh_token', 'passed',  1205),
    (4, 'ui',  'test_checkout',      'failed',  9310),
    (4, 'ui',  'test_search',        'failed',  1189),
    (4, 'ui',  'test_profile',       'passed',  2401),

    (5, 'api', 'test_login',         'passed',   421),
    (5, 'api', 'test_logout',        'passed',   177),
    (5, 'api', 'test_refresh_token', 'failed',  3044),
    (5, 'ui',  'test_checkout',      'passed',  8075),
    (5, 'ui',  'test_search',        'failed',  1203),
    (5, 'ui',  'test_profile',       'passed',  2355);
