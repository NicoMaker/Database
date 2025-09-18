- [vai al file principale](../Readme.md)

### **Tabelle del database**

#### 1. **Film**

| Campo            | Tipo    | Note                        |
| ---------------- | ------- | --------------------------- |
| film\_id         | INT     | PK, autoincrement           |
| titolo           | VARCHAR | Titolo del film             |
| anno\_produzione | YEAR    |                             |
| nazionalità      | VARCHAR |                             |
| lingua           | VARCHAR |                             |
| regista\_id      | INT     | FK → Regista(regista\_id)   |
| supporto\_id     | INT     | FK → Supporto(supporto\_id) |



#### 2. **Supporto**

| Campo        | Tipo    | Note                      |
| ------------ | ------- | ------------------------- |
| supporto\_id | INT     | PK, autoincrement         |
| tipo         | VARCHAR | Es. DVD, Blu-ray          |
| posizione    | VARCHAR | Posizione nella videoteca |


#### 3. **Attore**

| Campo          | Tipo    | Note              |
| -------------- | ------- | ----------------- |
| attore\_id     | INT     | PK, autoincrement |
| cognome        | VARCHAR |                   |
| nome           | VARCHAR |                   |
| data\_nascita  | DATE    |                   |
| luogo\_nascita | VARCHAR |                   |
| foto           | BLOB    | Opzionale         |


#### 4. **Regista**

| Campo          | Tipo    | Note              |
| -------------- | ------- | ----------------- |
| regista\_id    | INT     | PK, autoincrement |
| cognome        | VARCHAR |                   |
| nome           | VARCHAR |                   |
| data\_nascita  | DATE    |                   |
| luogo\_nascita | VARCHAR |                   |


#### 5. **Film\_Attore** (tabella di relazione N\:N)

| Campo      | Tipo    | Note                            |
| ---------- | ------- | ------------------------------- |
| film\_id   | INT     | FK → Film(film\_id)             |
| attore\_id | INT     | FK → Attore(attore\_id)         |
| ruolo      | VARCHAR | Opzionale, nome del personaggio |


### **Testo descrittivo delle tabelle**

1. **Film**: memorizza le informazioni principali di ciascun film, collegando il supporto e il regista.
2. **Supporto**: memorizza il tipo di supporto (DVD, Blu-ray, ecc.) e la posizione nella videoteca.
3. **Attore**: memorizza le informazioni sugli attori e opzionalmente la loro foto.
4. **Regista**: memorizza le informazioni sui registi.
5. **Film\_Attore**: tabella di relazione che associa più attori a un film, permettendo la relazione molti-a-molti.


## Diagrama ER

![Diagrama ER](1_Esercizio.png)