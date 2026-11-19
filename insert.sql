SET search_path TO codeclash, public;

-- 1. USERS (10 istifadəçi)
INSERT INTO codeclash.users (username, email, password_hash, rating, wins, losses) VALUES
('baghir',   'baghir@codeclash.az',  '$2b$10$hash01baghir', 1420, 15, 3),
('murad_coder',  'murad@codeclash.az',   '$2b$10$hash02murad',  1390, 14, 4),
('leyla_py',     'leyla@codeclash.az',   '$2b$10$hash03leyla',  1310, 11, 5),
('orxan_algo',   'orxan@codeclash.az',   '$2b$10$hash04orxan',  1275, 10, 6),
('nigar_tech',   'nigar@codeclash.az',   '$2b$10$hash05nigar',  1240,  9, 6),
('kamran_ai',    'kamran@codeclash.az',  '$2b$10$hash06kamran', 1190,  8, 7),
('aysel_code',   'aysel@codeclash.az',   '$2b$10$hash07aysel',  1150,  7, 8),
('tural_sql',    'tural@codeclash.az',   '$2b$10$hash08tural',  1100,  6, 9),
('sabina_dev',   'sabina@codeclash.az',  '$2b$10$hash09sabina', 1060,  5, 10),
('elvin_junior', 'elvin@codeclash.az',   '$2b$10$hash10elvin',  1010,  3, 11);

-- 2. QUESTIONS (10 proqramlaşdırma tapşırığı)
INSERT INTO codeclash.questions (title, description, difficulty, time_limit, test_cases) VALUES
('Cüt Ədəd Yoxlanışı', 'Verilmiş tam ədədin cüt olub-olmadığını qaytaran funksiya yazın.', 'Easy', 10,
 '[{"input": "8", "expected_output": "True"}, {"input": "13", "expected_output": "False"}, {"input": "0", "expected_output": "True"}]'::jsonb),

('Sətrin Tərsinə Çevrilməsi', 'Verilmiş mətni tərsinə çevirib qaytaran funksiya yazın.', 'Easy', 10,
 '[{"input": "''code''", "expected_output": "''edoc''"}, {"input": "''python''", "expected_output": "''nohtyp''"}]'::jsonb),

('Siyahı Elementlərinin Cəmi', 'Tam ədədlərdən ibarət siyahının elementləri cəmini tapın.', 'Easy', 10,
 '[{"input": "[1, 2, 3, 4]", "expected_output": "10"}, {"input": "[-5, 5, 10]", "expected_output": "10"}]'::jsonb),

('Palindrom Yoxlanışı', 'Sətrin sağdan və soldan eyni oxunub-oxunmadığını yoxlayın.', 'Easy', 15,
 '[{"input": "''radar''", "expected_output": "True"}, {"input": "''hello''", "expected_output": "False"}]'::jsonb),

('Ən Böyük Element', 'Siyahıdakı maksimum ədədi qaytaran funksiya yazın.', 'Easy', 10,
 '[{"input": "[3, 9, 1, 7]", "expected_output": "9"}, {"input": "[-10, -2, -5]", "expected_output": "-2"}]'::jsonb),

('Faktorial Hesablanması', 'Mənfi olmayan n ədədinin faktorialını hesablayın.', 'Medium', 15,
 '[{"input": "5", "expected_output": "120"}, {"input": "0", "expected_output": "1"}]'::jsonb),

('Fibonaççi Ədədi', 'n-ci Fibonaççi ədədini qaytaran funksiya yazın.', 'Medium', 15,
 '[{"input": "6", "expected_output": "8"}, {"input": "10", "expected_output": "55"}]'::jsonb),

('Saitlərin Sayı', 'İngilis əlifbasındakı kiçik sait hərflərin sayını tapın.', 'Medium', 15,
 '[{"input": "''codeclash''", "expected_output": "3"}, {"input": "''rhythm''", "expected_output": "0"}]'::jsonb),

('Two Sum İndeksləri', 'Cəmi target-ə bərabər olan iki elementin indeksini qaytarın.', 'Medium', 20,
 '[{"input": "[2, 7, 11, 15], 9", "expected_output": "[0, 1]"}, {"input": "[3, 2, 4], 6", "expected_output": "[1, 2]"}]'::jsonb),

('Sadə Ədəd Yoxlanışı', 'Verilmiş n ədədinin sadə olub-olmadığını müəyyən edin.', 'Hard', 20,
 '[{"input": "17", "expected_output": "True"}, {"input": "1", "expected_output": "False"}, {"input": "25", "expected_output": "False"}]'::jsonb);

-- 3. MATCHES (10 real-vaxt 1v1 matçı)
INSERT INTO codeclash.matches (player1_id, player2_id, winner_id, question_id, status) VALUES
(1, 2, 1, 1, 'finished'),
(2, 3, 2, 2, 'finished'),
(3, 4, 3, 3, 'finished'),
(4, 5, 4, 4, 'finished'),
(5, 6, 5, 5, 'finished'),
(1, 3, 1, 6, 'finished'),
(2, 4, 2, 7, 'finished'),
(6, 7, 6, 8, 'finished'),
(8, 9, 8, 9, 'finished'),
(9, 10, NULL, 10, 'active');

-- 4. SUBMISSIONS (12 kod göndərişi)
INSERT INTO codeclash.submissions (match_id, user_id, code, char_count, is_passed) VALUES
(1, 1, 'is_even=lambda n:n%2==0', 23, TRUE),
(1, 2, 'def is_even(n): return n % 2 == 0', 33, TRUE),
(2, 2, 'rev=lambda s:s[::-1]', 20, TRUE),
(2, 3, 'def rev(s): return "".join(reversed(s))', 39, TRUE),
(3, 3, 'sum_list=sum', 12, TRUE),
(3, 4, 'def sum_list(a): return sum(a)', 30, TRUE),
(4, 4, 'is_pal=lambda s:s==s[::-1]', 26, TRUE),
(4, 5, 'def is_pal(s): return s == s[::-1]', 34, TRUE),
(5, 5, 'max_num=max', 11, TRUE),
(6, 1, 'def fact(n): return 1 if n<2 else n*fact(n-1)', 45, TRUE),
(7, 2, 'fib=lambda n:n if n<2 else fib(n-1)+fib(n-2)', 44, TRUE),
(8, 6, 'vowels=lambda s:sum(c in "aeiou" for c in s)', 42, TRUE);

-- 5. LEADERBOARD (10 istifadəçi üçün reytinq cədvəli)
INSERT INTO codeclash.leaderboard (user_id, rank, points) VALUES
(1,  1, 1420),
(2,  2, 1390),
(3,  3, 1310),
(4,  4, 1275),
(5,  5, 1240),
(6,  6, 1190),
(7,  7, 1150),
(8,  8, 1100),
(9,  9, 1060),
(10, 10, 1010);
