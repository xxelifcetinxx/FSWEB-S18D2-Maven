-- 1) Biyografi türünü tür tablosuna ekleyiniz
INSERT INTO tur (turadi) VALUES ('Biyografi');

-- 2) Nurettin Belek isimli yazarı yazar tablosuna ekleyiniz
INSERT INTO yazar (adsoyad) VALUES ('Nurettin Belek');

-- 3) 10B sınıfındaki öğrencileri 10C sınıfına geçirin
UPDATE ogrenci SET sinif = '10C' WHERE sinif = '10B';

-- 4) Tüm kitapların puanını 5 puan arttırınız
UPDATE kitap SET puan = puan + 5;

-- 5) Adı Mehmet olan tüm yazarları silin
DELETE FROM yazar WHERE adsoyad LIKE 'Mehmet%';

-- 6) Kişisel Gelişim isimli bir tür oluşturun
INSERT INTO tur (turadi) VALUES ('Kişisel Gelişim');

-- 7) 'Benim Üniversitelerim' isimli kitabın türünü 'Kişisel Gelişim' yapın
UPDATE kitap
SET turid = (
    SELECT id FROM tur WHERE turadi = 'Kişisel Gelişim'
)
WHERE kitapadi = 'Benim Üniversitelerim';

-- 8) Tüm öğrencileri listeleyen "ogrencilistesi" adında bir fonksiyon oluşturun
CREATE OR REPLACE FUNCTION ogrencilistesi()
RETURNS TABLE (
    id INT,
    ogrno INT,
    ad VARCHAR,
    soyad VARCHAR,
    cinsiyet VARCHAR,
    dtarih DATE,
    sinif VARCHAR
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM ogrenci;
END;
$$ LANGUAGE plpgsql;

-- 9) kitap tablosuna yeni kitap eklemek için "ekle" adında bir prosedür oluşturun
CREATE OR REPLACE PROCEDURE ekle(
    p_kitapadi VARCHAR,
    p_sayfasayisi INT,
    p_puan INT,
    p_yazarid INT,
    p_turid INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO kitap(kitapadi, sayfasayisi, puan, yazarid, turid)
    VALUES (p_kitapadi, p_sayfasayisi, p_puan, p_yazarid, p_turid);
END;
$$;

-- 10) Öğrenci noya göre öğrenci silebilmeyi sağlayan "sil" adında bir prosedür oluşturun
CREATE OR REPLACE PROCEDURE sil(p_ogrno INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM ogrenci WHERE ogrno = p_ogrno;
END;
$$;
