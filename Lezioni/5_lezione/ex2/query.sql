# Quali clienti hanno effettuato ordini? Elenca il nome dei clienti e la data e il totale di ciascun ordine.
SELECT c.nome_cliente, o.data_ordine, o.totale
FROM Clienti c
JOIN Ordini o ON c.id_cliente = o.id_cliente;

# Mostra tutti i clienti, inclusi quelli che non hanno effettuato ordini. Qual è la data e il totale per ogni ordine, se presente?
SELECT c.nome_cliente, o.data_ordine, o.totale
FROM Clienti c
LEFT JOIN Ordini o ON c.id_cliente = o.id_cliente;


# Quali ordini sono stati effettuati e da quali clienti? Includi anche gli ordini senza clienti registrati.
SELECT 
    c.nome_cliente,
    o.data_ordine, 
    o.totale
FROM Ordini o
LEFT JOIN Clienti c 
    ON o.id_cliente = c.id_cliente;

# Mostra tutti i clienti e ordini, inclusi sia clienti senza ordini che ordini senza clienti. con union
SELECT
    c.nome_cliente,
    o.data_ordine,
    o.totale
FROM Clienti c
LEFT JOIN Ordini o
    ON c.id_cliente = o.id_cliente

UNION

SELECT
    c.nome_cliente,
    o.data_ordine,
    o.totale
FROM Clienti c
RIGHT JOIN Ordini o
    ON c.id_cliente = o.id_cliente;


# Quali sono i nomi dei prodotti, i prezzi e le loro categorie? Associa ogni prodotto con la categoria a cui appartiene.
SELECT 
    p.nome_prodotto,
    p.prezzo,
    c.nome_categoria
FROM Prodotti p
LEFT JOIN Categorie c
    ON p.id_categoria = c.id_categoria
WHERE c.nome_categoria IS NOT NULL;

# Elenca tutti i prodotti, inclusi quelli senza categoria. Cosa noti nei risultati?

SELECT 
    p.nome_prodotto,
    p.prezzo,
    c.nome_categoria
FROM Prodotti p
LEFT JOIN Categorie c
    ON p.id_categoria = c.id_categoria;

# Quali categorie sono presenti nel database? Elenca ogni categoria e i prodotti ad essa associati, se presenti.
SELECT 
    c.nome_categoria,
    p.nome_prodotto
FROM Categorie c
LEFT JOIN Prodotti p
    ON c.id_categoria = p.id_categoria;

# Mostra tutte le categorie e prodotti, includendo anche categorie senza prodotti e viceversa.
SELECT 
    c.nome_categoria,
    p.nome_prodotto
FROM Categorie c
LEFT JOIN Prodotti p
    ON c.id_categoria = p.id_categoria

UNION

SELECT 
    c.nome_categoria,
    p.nome_prodotto
FROM Categorie c
RIGHT JOIN Prodotti p
    ON c.id_categoria = p.id_categoria;

# Crea una combinazione tra tutti i clienti e tutti i prodotti. Quante righe ottieni?
SELECT 
    c.nome_cliente,
    p.nome_prodotto
FROM Clienti c
CROSS JOIN Prodotti p;


# Quali sono tutti i clienti e le categorie di prodotto che potrebbero acquistare? Crea tutte le combinazioni tra i clienti e le categorie.
SELECT 
    c.nome_cliente,
    ca.nome_categoria
FROM Clienti c
CROSS JOIN Categorie ca;


# Quali clienti hanno acquistato prodotti specifici? Elenca il nome cliente, il nome del prodotto e la quantità acquistata.
SELECT 
    c.nome_cliente,
    p.nome_prodotto,
    do.quantita
FROM Clienti c
JOIN Ordini o ON c.id_cliente = o.id_cliente
JOIN DettagliOrdine do ON o.id_ordine = do.id_ordine
JOIN Prodotti p ON do.id_prodotto = p.id_prodotto;


# Mostra tutti gli ordini e i dettagli degli ordini, inclusi quelli senza dettagli registrati. Cosa noti?
SELECT 
    o.id_ordine,
    o.data_ordine,
    do.id_prodotto,
    o.totale,
    do.quantita
FROM Ordini o
LEFT JOIN DettagliOrdine do ON o.id_ordine = do.id_ordine;


# Visualizza l’elenco di tutte le categorie e il numero di prodotti in ciascuna categoria. Includi anche le categorie senza prodotti.
SELECT 
    c.nome_categoria,
    COUNT(p.id_prodotto) AS numero_prodotti
FROM Categorie c
LEFT JOIN Prodotti p ON c.id_categoria = p.id_categoria
GROUP BY c.nome_categoria;


# Mostra tutte le categorie che non hanno prodotti associati.
SELECT
    c.nome_categoria
FROM Categorie c
LEFT JOIN Prodotti p ON c.id_categoria = p.id_categoria
WHERE p.id_prodotto IS NULL;


# Trova tutti gli ordini che contengono prodotti senza una categoria associata.
SELECT
    o.id_ordine,
    o.data_ordine,
    o.totale,
    p.nome_prodotto
FROM Ordini o
JOIN DettagliOrdine do ON o.id_ordine = do.id_ordine
JOIN Prodotti p ON do.id_prodotto = p.id_prodotto
WHERE p.id_categoria IS NULL;


# Trova gli ordini senza dettagli registrati.
SELECT
    o.id_ordine,
    o.data_ordine,
    o.totale
FROM Ordini o
LEFT JOIN DettagliOrdine do ON o.id_ordine = do.id_ordine
WHERE do.id_prodotto IS NULL;

# Visualizza l’elenco di clienti che non hanno effettuato ordini.
SELECT
    c.nome_cliente
FROM Clienti c
LEFT JOIN Ordini o ON c.id_cliente = o.id_cliente
WHERE o.id_ordine IS NULL;


# Trova l’elenco dei prodotti acquistati da ciascun cliente. Includi anche i clienti che non hanno acquistato nulla.
SELECT
    c.nome_cliente,
    p.nome_prodotto
FROM Clienti c
LEFT JOIN Ordini o ON c.id_cliente = o.id_cliente
LEFT JOIN DettagliOrdine do ON o.id_ordine = do.id_ordine
LEFT JOIN Prodotti p ON do.id_prodotto = p.id_prodotto;

# Visualizza i dettagli degli ordini per categoria di prodotto.
SELECT
    c.nome_categoria,
    o.data_ordine,
    o.totale
FROM Ordini o
JOIN DettagliOrdine do ON o.id_ordine = do.id_ordine
JOIN Prodotti p ON do.id_prodotto = p.id_prodotto
JOIN Categorie c ON p.id_categoria = c.id_categoria;

# Mostra tutti i prodotti, anche quelli non acquistati, insieme al totale delle quantità ordinate.
SELECT
    p.nome_prodotto,
    SUM(do.quanti
    ) AS totale_quantita_ordinate
FROM Prodotti p
LEFT JOIN DettagliOrdine do ON p.id_prodotto = do.id_prodotto
GROUP BY p.nome_prodotto;