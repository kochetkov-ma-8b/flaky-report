PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS test_result;
DROP TABLE IF EXISTS test_run;

CREATE TABLE test_run (
    id         INTEGER PRIMARY KEY,
    branch     TEXT    NOT NULL,
    commit_sha TEXT    NOT NULL,
    started_at TEXT    NOT NULL
);

CREATE TABLE test_result (
    run_id      INTEGER NOT NULL REFERENCES test_run (id) ON DELETE CASCADE,
    suite       TEXT    NOT NULL,
    test_name   TEXT    NOT NULL,
    status      TEXT    NOT NULL CHECK (status IN ('passed', 'failed', 'skipped')),
    duration_ms INTEGER NOT NULL CHECK (duration_ms >= 0),
    PRIMARY KEY (run_id, suite, test_name)
);

CREATE INDEX idx_test_result_test ON test_result (suite, test_name);
CREATE INDEX idx_test_result_status ON test_result (status);
