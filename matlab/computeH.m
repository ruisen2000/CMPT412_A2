function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
% input is in cartesian coordinates
    A = zeros(9,9);
    
    [r,c] = size(x1);

    for i = 1:r
        x = x1(i, 1);
        y = x1(i, 2);
        x_p = x2(i,1);
        y_p = x2(i,2);
        
        % A derived from least squares method in text
        if mod(i,2) == 1
            A(i,:) = [-x, -y, -1, 0, 0, 0, x*x_p, y*x_p, x_p];        
        else
            A(i,:) = [0, 0, 0, -x, -y, -1, x*y_p, y*y_p, y_p];
        end
    end

    [V,D] = eig(A'*A);   
    D = diag(D);
    [~,index] = min(D);  % solution of h is eigenvector with minimum eigenvalue
    
    % if there are not enough points to solve for all h values, select the
    % last eigenvector
    %if r <= 4
     %   [~,c_eig] = size(V);
      %  H2to1 = V(:, c_eig);
    %else
        H2to1 = V(:, index);
   % end
    
    H2to1 = vec2mat(H2to1, 3);

end
