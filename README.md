# flaky-report

SQLite schema plus a set of SQL reports over CI test-run history: which tests are flaky, which are
permanently red, pass rate per suite, slowest tests, per-run health. Plain SQL, no dependencies
beyond the `sqlite3` CLI.

## Run

```sh
sqlite3 runs.db < sql/schema.sql
sqlite3 runs.db < sql/seed.sql
sqlite3 runs.db < sql/reports.sql
```

`sql/seed.sql` holds five sample runs of six tests so the reports return rows out of the box.
Point the same reports at a real database by loading only `sql/schema.sql` and inserting your own
rows into `test_run` and `test_result`.

## Tables

| Table | Columns |
|-------|---------|
| `test_run` | `id`, `branch`, `commit_sha`, `started_at` |
| `test_result` | `run_id`, `suite`, `test_name`, `status`, `duration_ms` |

`status` is constrained to `passed` / `failed` / `skipped`; `test_result` cascades on run deletion.

## Reports

1. Flaky tests - both passed and failed at least once, worst failure ratio first.
2. Always red - never passed, a defect rather than flakiness.
3. Pass rate per suite, skipped results excluded from the denominator.
4. Five slowest tests by average duration.
5. Per-run failed/total, newest run first.

Sample output of report 1 on the seeded data:

```
suite  test_name           runs  failed  fail_pct
-----  ------------------  ----  ------  --------
api    test_refresh_token  5     3       60.0
ui     test_checkout       5     2       40.0
```

Tested with SQLite 3.43.2.
