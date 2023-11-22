CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    ultima_acao TIMESTAMP
);


CREATE TABLE acesso (
    id_acesso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    acao ENUM('login', 'logout'),
    data_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

DELIMITER //

CREATE TRIGGER atualiza_ultima_acao
AFTER INSERT ON acesso
FOR EACH ROW
BEGIN
    IF NEW.acao IN ('login', 'logout') THEN
        UPDATE usuario
        SET ultima_acao = NEW.data_acesso
        WHERE id_usuario = NEW.id_usuario;
    END IF;
END;
//

DELIMITER ;