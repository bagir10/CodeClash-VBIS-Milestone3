# CodeClash – Fiziki Verilənlər Bazasının Reallaşdırılması (Milestone 3)

**Universitet:** Qarabağ Universiteti  
**Fənn:** Verilənlər Bazasının İdarəetmə Sistemləri (VBİS)  
**Qrup:** MRM24  
**Hazırlayanlar:** Bağır Əsədullayev, Murad Muradov  
**MÜİT (DBMS):** pgAdmin 4  

---

## 📌 Layihə Haqqında

**CodeClash** proqramçıların real-vaxt rejimində təkbətək (1v1) duellərdə yarışdığı və verilmiş alqoritmik məsələni bütün avtomatik testlərdən keçməklə ən az simvol sayı ilə həll etməyə çalışdığı interaktiv platformadır

Bu repozitoriyada Milestone 2 mərhələsində layihələndirilmiş **3NF** relyasiya sxeminin PostgreSQL mühitində fiziki reallaşdırılması, məhdudiyyətlər , test məlumatları və yoxlama nəticələri təqdim olunur.

---

## 🗂️ Repozitoriyanın Strukturu

* `schema.sql` — `codeclash` sxemi, 5 əsas cədvəl (`users`, `questions`, `matches`, `submissions`, `leaderboard`), `CHECK`/`UNIQUE`/`FK` məhdudiyyətləri, `TRIGGER` və `VIEW` obyektləri.
* `insert.sql` — Hər bir əsas və əlaqəli cədvələ minimum 10 test qeydi daxil edən SQL skripti.
* `validation.sql` — Cədvəl saylarını, `JOIN` əlaqələrini və məhdudiyyətlərin (`CHECK`, `UNIQUE`, `FOREIGN KEY`) bloklama mexanizmini yoxlayan sorğular.


---

## ⚙️ Tətbiq Edilmiş Texniki Həllər və Bonus Obyektlər

1. **Xüsusi Sxem (`codeclash`):** Sistem cədvəllərindən izolyasiya üçün `CREATE SCHEMA codeclash` istifadə edilmişdir.
2. **Avtomatik İdentifikatorlar:** Bütün birincili açarlar (`id`) `INT GENERATED ALWAYS AS IDENTITY` ilə qurulmuşdur.
3. **JSONB Test Keysləri:** Müxtəlif sayda giriş/çıxış testlərini çevik saxlamaq üçün `questions.test_cases` sütunu `JSONB` tipində yaradılmışdır
4. **Trigger (`trg_before_insert_submission`):** `submissions` cədvəlinə kod əlavə edilərkən və ya yenilənərkən `char_count` dəyərini avtomatik hesablayır.
5. **View-lar (`vw_leaderboard_details`, `vw_match_overview`):** Cədvəllərarası `1:N` və `1:1` əlaqələri birləşdirərək oxunaqlı hesabat görünüşü yaradır

---

## 📊 Verilənlər Bazasının Yoxlanılması (Validation Results)

### 1.chk_different_players xətası 
<img width="1285" height="960" alt="991ab3e8-e353-4bc4-8f2f-74430a39153a" src="https://github.com/user-attachments/assets/08ca327c-be26-4592-a2a9-418a4f1f6c17" />

### 2.leaderboard_user_id_key xətası 
<img width="1252" height="932" alt="b8b9554c-c534-4bb0-bf5e-82df33e4ef10" src="https://github.com/user-attachments/assets/af29d06f-33ac-4178-8e19-46dca27cdfda" />

### 3.vw_match_overview 10 sətirlik nəticə
<img width="1600" height="832" alt="28bc4b1a-d20d-4a39-b448-e2ea6242dcf3" src="https://github.com/user-attachments/assets/bddd88b6-d03c-40af-aea6-1de53f66c835" />  
### 4.vw_leaderboard_details 10 sətirlik nəticə
<img width="1397" height="1011" alt="223d2ddd-65ee-4cbd-b656-3ff461b39eb6" src="https://github.com/user-attachments/assets/e4d18a4a-3a6e-4e6b-b98e-6e0690352614" />

### 5. ER Diaqramı (pgAdmin 4 ERD)
<img width="846" height="802" alt="8474c54c-decb-4395-bebc-02fe9b8746a6" src="https://github.com/user-attachments/assets/c5dac005-1f22-4854-a0a2-86adafb3610f" />
