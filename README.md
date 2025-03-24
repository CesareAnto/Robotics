# Simulazione di Droni con Navigazione Basata su Potenziali Artificiali

Questo progetto MATLAB simula un sistema multi-drone in un ambiente bidimensionale con ostacoli, utilizzando il metodo dei **potenziali artificiali**. Ogni drone viene:
- Attratto verso una destinazione comune tramite una **forza attrattiva**.
- Respinto da ostacoli e dagli altri droni tramite **forze repulsive**.

La simulazione si aggiorna nel tempo e visualizza:
- Le forze attrattive applicate.
- Le forze repulsive dagli ostacoli.
- Le forze repulsive tra droni.
- La posizione aggiornata dei droni in tempo reale.

---

## ⚙️ Requisiti

- MATLAB (versione consigliata: R2020 o superiore)
- Nessun toolbox esterno richiesto

---

## 📂 Struttura del Progetto

progetto-droni/ ├── simulazione_droni.m # Script principale ├── calcolaForzaRepulsiva.m # Funzione per il calcolo della forza repulsiva ├── README.md # Documentazione del progetto ├── .gitignore # File per ignorare i file temporanei


---

## 🚀 Come Funziona

All'interno del ciclo temporale:

1. **Forza attrattiva**:
   - Ogni drone calcola la forza diretta verso la destinazione.
   - Salvata in `forzeAttr(t, i)` come norma del vettore.

2. **Forze repulsive dagli ostacoli**:
   - Se un ostacolo è più vicino della `distanza_sicurezza`, si calcola una forza repulsiva.
   - Accumulata in `forza_repulsiva_totale`.

3. **Forze repulsive tra droni**:
   - Se due droni sono troppo vicini (`distanza_minima_droni`), si calcola una forza repulsiva.
   - Anch'essa sommata a `forza_repulsiva_totale`.

4. **Movimento**:
   - La forza totale (attrattiva + repulsiva) viene trasformata in un vettore di movimento.
   - La nuova posizione viene aggiornata con:
     ```matlab
     Q(i, :) = Q(i, :) + movimento;
     ```

5. **Aggiornamento grafico**:
   - Posizione dei droni (`XData`, `YData`)
   - Grafico delle forze attrattive (verde)
   - Grafico delle forze repulsive tra droni (blu)
   - Grafico delle forze repulsive dagli ostacoli (rosso)

---

## ▶️ Esecuzione

1. Clona o scarica il repository:
   ```bash
   git clone https://github.com/tuo-username/progetto-droni.git

