DELIMITER $$
DROP PROCEDURE IF EXISTS MostrarColumnes;
CREATE PROCEDURE MostrarColumnes(
    IN nomdb VARCHAR(32),
    IN nomtaula VARCHAR(32)
)
BEGIN
    DECLARE fi INT DEFAULT 0;
    DECLARE nom_columna VARCHAR(64);
    DECLARE tipus_dada VARCHAR(64);

    -- Declarem un cursor per obtenir les columnes i els tipus de dades
    DECLARE columnes_cursor CURSOR FOR
        SELECT COLUMN_NAME, COLUMN_TYPE
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = nomdb AND TABLE_NAME = nomtaula ORDER BY COLUMN_NAME;

    -- Handler per quan no hi ha més files al cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Obrim el cursor
    OPEN columnes_cursor;

    -- Bucle per iterar sobre els resultats del cursor
    read_loop: LOOP
        FETCH columnes_cursor INTO nom_columna, tipus_dada;
        IF fi THEN
            LEAVE read_loop;
        END IF;

        -- Mostrem el nom de la columna i el tipus de dades
        SELECT CONCAT('Columna: ', nom_columna, ' - Tipus de dada: ', tipus_dada) AS Info_Columna;
    END LOOP;

    -- Tanquem el cursor
    CLOSE columnes_cursor;
END$$

DELIMITER ;