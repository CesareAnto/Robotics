clc, clear, close all
% q: robot location
% world: environment

q = [-1.5,3.2;...
     1.5,3.3;...
     3.5,-2.25]; % abbiamo tre robot con posizioni x e y


 %q = randn(10,2); % per generare n robot

%descriviamo l'ambiente: è una cella

world = {[1 0 5.8],...
         [1 0 -5.8],...
         [0 1 5.8],...
         [0 1 -5.8]} %


Vertex = afVoronoi(q,world);
% vertex è una funzione dei vertici dell'ambiente

afDrawRegions(Vertex, q, 'voronoi0');



% per calcolare il centroide  dovremmo integrare la funzione phi attraverso
% tutta la regione, mediante le formule viste a lezione.
% Nel nostro caso phi è uniforme, costante in W; possiamo quindi trovare una
% soluzione in forma chiusa. La generica regione di Voronoi è nota, si
% hanno un numero di vertici (l_i) che numeriamo.

%se phi è uniforme, cioè costante in ogni punto dello spazio, possiamo
%calcolare la massa M_i come 1/2*sommatoria da 1 a l_i di g_e
% dove g_e  = xe*y_e+1 - x_e+1 * y_e... VEDI APPUNTI IPAD

Ci = centroid([-5.8 5.8;-0.085 5.8;0.119429 -0.332864;-5.8 -5.8])
%Ci_2 = centroid([-5.8 5.8; ])
%Ci_3 = centroid([-5.8 5.8; ])




