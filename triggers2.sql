-- Criar a tabela historico_estoque se ainda não existir
CREATE TABLE IF NOT EXISTS historico_estoque (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_item INT,
    quantidade_anterior INT,
    quantidade_nova INT,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criar o trigger AFTER UPDATE na tabela estoque
DELIMITER //
CREATE TRIGGER registro_alteracao_estoque AFTER UPDATE ON estoque
FOR EACH ROW
BEGIN
    -- Verificar se houve alteração na coluna quantidade
    IF OLD.quantidade <> NEW.quantidade THEN
        -- Inserir um registro na tabela historico_estoque
        INSERT INTO historico_estoque (id_item, quantidade_anterior, quantidade_nova)
        VALUES (OLD.id_item, OLD.quantidade, NEW.quantidade);
    END IF;
END;
//
DELIMITER ;