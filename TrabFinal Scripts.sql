CREATE OR REPLACE PROCEDURE buscar_jogador_ou_equipe(
    IN p_busca VARCHAR(50),
    INOUT resultado REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM jogador j
        JOIN jogador_equipe je ON j.id = je.idjogador
        WHERE LOWER(j.nickname) = LOWER(p_busca)
        AND je.data_saida IS NULL
    ) THEN

        OPEN resultado FOR
            SELECT
                j.nome AS jogador,
                j.nickname,
                je.funcao,
                e.nome AS equipe
            FROM jogador j
            JOIN jogador_equipe je ON j.id = je.idjogador
            JOIN equipe e ON e.id = je.idequipe
            WHERE LOWER(j.nickname) = LOWER(p_busca)
            AND je.data_saida IS NULL;

    ELSE

        OPEN resultado FOR
            SELECT
                j.nome AS jogador,
                j.nickname,
                je.funcao,
                e.nome AS equipe
            FROM equipe e
            JOIN jogador_equipe je ON e.id = je.idequipe
            JOIN jogador j ON j.id = je.idjogador
            WHERE LOWER(e.nome) = LOWER(p_busca)
            AND je.data_saida IS NULL
            ORDER BY je.funcao;

    END IF;
END;
$$;