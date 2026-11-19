SET search_path TO codeclash, public;

-- 1. Cədvəllərin siyahısı və qeyd sayları
SELECT 'users' AS cedvel, COUNT(*) AS qeyd_sayi FROM users
UNION ALL
SELECT 'questions', COUNT(*) FROM questions
UNION ALL
SELECT 'matches', COUNT(*) FROM matches
UNION ALL
SELECT 'submissions', COUNT(*) FROM submissions
UNION ALL
SELECT 'leaderboard', COUNT(*) FROM leaderboard;

-- 2. JOIN və VIEW əlaqələrinin yoxlanılması
SELECT * FROM vw_match_overview;
SELECT * FROM vw_leaderboard_details;

-- 3. Code Golf qaydasının yoxlanılması (ən az simvol işlədən qalib)
SELECT
    m.id AS match_id,
    u.username,
    s.code,
    s.char_count,
    s.is_passed
FROM submissions s
JOIN users u ON s.user_id = u.id
JOIN matches m ON s.match_id = m.id
WHERE m.id = 1
ORDER BY s.char_count ASC;

-- 4. Constraint yoxlamaları (Qəsdən xəta testləri)
-- Test A: CHECK constraint (player1_id <> player2_id)
INSERT INTO matches (player1_id, player2_id, question_id) VALUES (1, 1, 1);

-- Test B: UNIQUE constraint (təkrar email)
INSERT INTO users (username, email, password_hash) VALUES ('test_user', 'baghir@codeclash.az', 'hash123');

-- Test C: FOREIGN KEY constraint (mövcud olmayan user_id)
INSERT INTO leaderboard (user_id, rank, points) VALUES (999, 11, 500);
