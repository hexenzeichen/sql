SET @db_name = '';

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS localhostize(IN db_name VARCHAR(255))
BEGIN


END $$
DELIMITER ;


CALL localhostize(@db_name);

DROP PROCEDURE IF EXISTS localhostize;

