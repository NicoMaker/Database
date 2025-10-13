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
    op.quantita
FROM Clienti c
JOIN Ordini o ON c.id_cliente = o.id_cliente
JOIN OrdiniProdotti op ON o.id_ordine = op.id_ordine
JOIN Prodotti p ON op.id_prodotto = p.id_prodotto;