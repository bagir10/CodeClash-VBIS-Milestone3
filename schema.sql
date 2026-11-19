-- Verilənlər bazasının yaradılması
CREATE DATABASE codeclash_db;

-- Xüsusi PostgreSQL Schema yaradılması
CREATE SCHEMA IF NOT EXISTS codeclash;
SET search_path TO codeclash, public;

-- Təmiz yenidənqurma üçün mövcud obyektlərin silinməsi
DROP VIEW IF EXISTS codeclash.vw_match_overview CASCADE;
DROP VIEW IF EXISTS codeclash.vw_leaderboard_details CASCADE;
DROP TABLE IF EXISTS codeclash.leaderboard CASCADE;
DROP TABLE IF EXISTS codeclash.submissions CASCADE;
DROP TABLE IF EXISTS codeclash.matches CASCADE;
DROP TABLE IF EXISTS codeclash.questions CASCADE;
DROP TABLE IF EXISTS codeclash.users CASCADE;

-- 1. USERS Cədvəli
CREATE TABLE codeclash.users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rating INT NOT NULL DEFAULT 1000 CHECK (rating >= 0),
    wins INT NOT NULL DEFAULT 0 CHECK (wins >= 0),
    losses INT NOT NULL DEFAULT 0 CHECK (losses >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. QUESTIONS Cədvəli
CREATE TABLE codeclash.questions (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(150) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    difficulty VARCHAR(20) NOT NULL DEFAULT 'Easy' CHECK (difficulty IN ('Easy', 'Medium', 'Hard')),
    time_limit INT NOT NULL DEFAULT 15 CHECK (time_limit > 0 AND time_limit <= 120),
    test_cases JSONB NOT NULL DEFAULT '[]'::jsonb CHECK (jsonb_typeof(test_cases) = 'array')
);

-- 3. MATCHES Cədvəli
CREATE TABLE codeclash.matches (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player1_id INT NOT NULL REFERENCES codeclash.users(id) ON DELETE CASCADE,
    player2_id INT NOT NULL REFERENCES codeclash.users(id) ON DELETE CASCADE,
    winner_id INT REFERENCES codeclash.users(id) ON DELETE SET NULL,
    question_id INT NOT NULL REFERENCES codeclash.questions(id) ON DELETE RESTRICT,
    status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('waiting', 'active', 'finished', 'cancelled')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_different_players CHECK (player1_id <> player2_id),
    CONSTRAINT chk_valid_winner CHECK (winner_id IS NULL OR winner_id IN (player1_id, player2_id))
);

-- 4. SUBMISSIONS Cədvəli
CREATE TABLE codeclash.submissions (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    match_id INT NOT NULL REFERENCES codeclash.matches(id) ON DELETE CASCADE,
    user_id INT NOT NULL REFERENCES codeclash.users(id) ON DELETE CASCADE,
    code TEXT NOT NULL CHECK (LENGTH(TRIM(code)) > 0),
    char_count INT NOT NULL CHECK (char_count > 0),
    is_passed BOOLEAN NOT NULL DEFAULT FALSE,
    submitted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 5. LEADERBOARD Cədvəli
CREATE TABLE codeclash.leaderboard (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT NOT NULL UNIQUE REFERENCES codeclash.users(id) ON DELETE CASCADE,
    rank INT NOT NULL CHECK (rank > 0),
    points INT NOT NULL DEFAULT 0 CHECK (points >= 0),
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Trigger: Göndərilən kodun simvol sayını avtomatik hesablayır
CREATE OR REPLACE FUNCTION codeclash.fn_calculate_char_count()
RETURNS TRIGGER AS $$
BEGIN
    NEW.char_count := LENGTH(NEW.code);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_insert_submission
BEFORE INSERT OR UPDATE OF code ON codeclash.submissions
FOR EACH ROW
EXECUTE FUNCTION codeclash.fn_calculate_char_count();

-- View-lar
CREATE OR REPLACE VIEW codeclash.vw_leaderboard_details AS
SELECT
    l.rank,
    u.username,
    u.rating,
    u.wins,
    u.losses,
    l.points,
    l.last_updated
FROM codeclash.leaderboard l
JOIN codeclash.users u ON l.user_id = u.id
ORDER BY l.rank ASC;

CREATE OR REPLACE VIEW codeclash.vw_match_overview AS
SELECT
    m.id AS match_id,
    u1.username AS player1,
    u2.username AS player2,
    COALESCE(uw.username, 'Davam edir') AS winner,
    q.title AS question_title,
    q.difficulty,
    m.status,
    m.created_at
FROM codeclash.matches m
JOIN codeclash.users u1 ON m.player1_id = u1.id
JOIN codeclash.users u2 ON m.player2_id = u2.id
LEFT JOIN codeclash.users uw ON m.winner_id = uw.id
JOIN codeclash.questions q ON m.question_id = q.id;
