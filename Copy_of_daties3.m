clc, clear, close all
% Definizione delle posizioni di 10 droni
q = randn(10, 2); % Genera 10 posizioni casuali per i droni

% Descrizione dell'ambiente
world = {[1 0 5.8],...
         [1 0 -5.8],...
         [0 1 5.8],...
         [0 1 -5.8]};

% Calcolo dei vertici delle regioni di Voronoi
Vertex = afVoronoi(q, world);

% Disegno delle regioni di Voronoi
afDrawRegions(Vertex, q, 'voronoi0');

% Calcolo dei centroidi per ogni regione di Voronoi
nRegioni = length(Vertex); % Numero di regioni di Voronoi
centroidi = zeros(nRegioni, 2); % Inizializzazione dell'array per i centroidi

for i = 1:nRegioni
    % Applica una tolleranza per rimuovere vertici troppo vicini
    verticiPuliti = uniquetol(Vertex{i}, 0.001, 'ByRows', true);
    
    % Ordina i vertici
    verticiOrdinati = ordinaVertici(verticiPuliti);

    % Crea un poligono dalla i-esima regione
    poligono = polyshape(verticiOrdinati(:, 1), verticiOrdinati(:, 2));
    
    % Calcola il centroide del poligono
    [ cx,cy] = centroid(poligono);
    
    % Memorizza il centroide nell'array
    centroidi(i, :) = [cx, cy];
end

% Definizione della funzione locale
function verticiOrdinati = ordinaVertici(vertici)
    % Calcola il baricentro dei vertici
    centroide = mean(vertici);

    % Trasla i vertici in modo che il centroide sia all'origine
    verticiTraslati = vertici - centroide;

    % Calcola gli angoli e ordina i vertici
    angoli = atan2(verticiTraslati(:,2), verticiTraslati(:,1));
    [~, ordine] = sort(angoli);
    verticiOrdinati = vertici(ordine, :);
end

% Ora, "centroidi" contiene i centroidi di tutte le regioni di Voronoi
