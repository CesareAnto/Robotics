function Ci = centroid(Vi)
     n = size(Vi, 1);
     Vi(n+1, :) = Vi(1, :); % Estendi Vi per tornare al primo vertice
     g = zeros(n, 1);

    for l = 1:n
        xl = Vi(l,1);
        yl = Vi(l,2);
        xlp = Vi(l+1,1);
        ylp = Vi(l+1,2);

        g(l) = xl * ylp - xlp * yl;
    end

    % Area (massa)
    mi = 0.5 * sum(g);

    % Calcolo del centroide
    a = 0; b = 0;

    for l = 1:n
        xl = Vi(l,1);
        yl = Vi(l,2);
        xlp = Vi(l+1,1);
        ylp = Vi(l+1,2);

        a = a + (xl + xlp) * g(l);
        b = b + (yl + ylp) * g(l);
    end

    Ci = 1/(6*mi) * [a;b];
end
