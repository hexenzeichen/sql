SET @db_name = '';

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS localhostize(IN db_name VARCHAR(255))
BEGIN

DECLARE finished INTEGER DEFAULT 0;
DECLARE t_name VARCHAR(255);
DECLARE update_query VARCHAR(225);


DECLARE cur_tables CURSOR FOR SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_SCHEMA = db_name AND TABLE_NAME LIKE '%options';
	
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

OPEN cur_tables;

tables_loop: LOOP

    FETCH cur_tables INTO t_name;

    IF finished = 1 THEN
	LEAVE tables_loop;
    END IF;

    SET update_query = CONCAT('UPDATE ', t_name, ' SET option_value = CONCAT(\'http\:\/\/localhost/\', SUBSTRING_INDEX(option_value, \'/\', -1)) WHERE option_name IN (\'siteurl\',\'home\')');
    PREPARE execute_query FROM update_query;
    EXECUTE execute_query;
    DEALLOCATE PREPARE execute_query;

END LOOP tables_loop;

CLOSE cur_tables;

END $$
DELIMITER ;


CALL localhostize(@db_name);

DROP PROCEDURE IF EXISTS localhostize;

