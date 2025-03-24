clearvars, clc, close all;

% Impostazioni iniziali
sampling_time = 0.01; % 10 ms
velocita_droni = 0.8 % Fattore di velocità dei droni
numDroni =5; % Numero di droni
Q = randn(numDroni, 2) * 2; % Posizioni iniziali casuali dei droni

% Descrizione dell'ambiente per Voronoi
world = {[1 0 5.8], [1 0 -5.8], [0 1 5.8], [0 1 -5.8]};
Vertex = afVoronoi(Q, world); % Calcolo iniziale delle regioni di Voronoi

% Definizione degli ostacoli fissi
numOstacoli = 5;
Ostacoli = randn(numOstacoli, 2) * 3;
raggioOstacoli = 0.5;

% Target fisso
target = [5, 5];

% Inizializzazione della figura
fig = figure;
ax1 = subplot(4,1,1); % Grafico per la simulazione dei droni
ax2 = subplot(4,1,2); % Grafico per le forze attrattive
ax3 = subplot(4,1,3); % Grafico per le forze repulsive tra droni
ax4 = subplot(4,1,4); % Grafico per le forze repulsive dagli ostacoli
hold(ax1, 'on');
grid(ax1, 'on');
hold(ax2, 'on');
hold(ax3, 'on');
hold(ax4, 'on');
title(ax2, 'Forze Attrattive');
title(ax3, 'Forze Repulsive tra Droni');
title(ax4, 'Forze Repulsive dagli Ostacoli');

% Visualizzazione iniziale di droni, ostacoli e target nel subplot ax1
hDroni = plot(ax1, Q(:,1), Q(:,2), 'o', 'Color', 'blue');
viscircles(ax1, Ostacoli, raggioOstacoli * ones(numOstacoli, 1), 'Color', 'red');
hTarget = plot(ax1, target(1), target(2), 'p', 'Color', 'green', 'MarkerSize', 15, 'LineWidth', 2);
afDrawRegions(Vertex, Q, 'voronoi0');

% Parametri per l'evitamento degli ostacoli e forze attrattive
k_attr = 0.5;
k_rep = 100;
distanza_sicurezza = raggioOstacoli + 0.5;
distanza_minima_droni = 1;

% Inizializzazione delle variabili per il plot delle forze
tempo = 0:sampling_time:50; % Array di tempo per il plot
forzeAttr = zeros(length(tempo), numDroni);
forzeRepDroni = zeros(length(tempo), numDroni);
forzeRepOstacoli = zeros(length(tempo), numDroni);

% Funzione per calcolare la forza repulsiva
calcolaForzaRepulsiva = @(distanza, distanzaSicurezza, k_rep) ...
    k_rep * (1/norm(distanza) - 1/distanzaSicurezza) * (distanza/norm(distanza)^3);

% Loop di simulazione
for t = 1:length(tempo)
    for i = 1:numDroni
        % Calcolo forza attrattiva verso il target
        forza_attrattiva = k_attr * (target - Q(i, :));
        forzeAttr(t, i) = norm(forza_attrattiva);

        % Calcolo forza repulsiva dagli ostacoli e tra i droni
        forza_repulsiva_totale = [0, 0];
        % Calcolo forze repulsive dagli ostacoli
        for j = 1:numOstacoli
            distanza = Q(i, :) - Ostacoli(j, :);
            if norm(distanza) < distanza_sicurezza
                forza_repulsiva_totale = forza_repulsiva_totale + ...
                    calcolaForzaRepulsiva(distanza, distanza_sicurezza, k_rep);
            end
        end
        forzeRepOstacoli(t, i) = norm(forza_repulsiva_totale);

        % Calcolo forze repulsive dagli altri droni
        for j = 1:numDroni
            if j ~= i
                distanza_droni = Q(i, :) - Q(j, :);
                if norm(distanza_droni) < distanza_minima_droni
                    forza_repulsiva_totale = forza_repulsiva_totale + ...
                        calcolaForzaRepulsiva(distanza_droni, distanza_minima_droni, k_rep);
                end
            end
        end
        forzeRepDroni(t, i) = norm(forza_repulsiva_totale);

        % Determinazione della direzione e dell'intensità del movimento
        forza_totale = forza_attrattiva + forza_repulsiva_totale;
        movimento = forza_totale * sampling_time * velocita_droni; 
        Q(i, :) = Q(i, :) + movimento;
    end

    % Aggiornamento grafico dei droni
    set(hDroni, 'XData', Q(:,1), 'YData', Q(:,2));

    % Aggiornamento del grafico delle forze attrattive
    cla(ax2); % Pulisce il subplot delle forze attrattive
    plot(ax2, tempo(1:t), forzeAttr(1:t, :), 'g');
    xlabel(ax2, 'Tempo');
    ylabel(ax2, 'intensità del Potenziale');

    % Aggiornamento del grafico delle forze repulsive tra i droni
    cla(ax3); % Pulisce il subplot delle forze repulsive tra i droni
    plot(ax3, tempo(1:t), forzeRepDroni(1:t, :), 'b');
    xlabel(ax3, 'Tempo');
    ylabel(ax3, 'Intensità Forza');

    % Aggiornamento del grafico delle forze repulsive dagli ostacoli
    cla(ax4); % Pulisce il subplot delle forze repulsive dagli ostacoli
    plot(ax4, tempo(1:t), forzeRepOstacoli(1:t, :), 'r');
    xlabel(ax4, 'Tempo');
    ylabel(ax4, 'Intensità Forza');

    drawnow;
    pause(sampling_time);
end





